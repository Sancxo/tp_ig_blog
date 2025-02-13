defmodule IgBlogWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(IgBlogWeb.Types)

  alias IgBlogWeb.Resolvers.NewsResolvers
  alias IgBlogWeb.Resolvers.AccountsResolvers
  alias IgBlog.Accounts.User

  query do
    # News
    @desc "Get all published posts"
    field :list_publications, list_of(:post) do
      resolve(&NewsResolvers.list_publications/3)
    end

    field :list_drafts, list_of(:post) do
      resolve(&NewsResolvers.list_drafts/3)
    end

    field :get_post, :post do
      arg(:slug, non_null(:string))
      resolve(&NewsResolvers.get_post/3)
    end

    field :get_draft, :post do
      arg(:slug, non_null(:string))
      resolve(&NewsResolvers.get_draft/3)
    end

    # Accounts
    field :list_users, list_of(:user) do
      resolve(&AccountsResolvers.list_users/3)
    end

    field :get_user, :user do
      arg(:id, non_null(:id))
      resolve(&AccountsResolvers.get_user/3)
    end

    field :log_in, :user do
      arg(:fullname, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&AccountsResolvers.log_in/3)

      middleware(fn resolution, _ ->
        with %{value: %User{id: user_id}} <- resolution do
          resolution
          |> Map.update!(:context, fn ctx ->
            Map.put(ctx, :user_id, user_id)
          end)
        end
      end)
    end

    field :log_out, :user do
      resolve(&AccountsResolvers.log_out/3)

      middleware(fn resolution, _ ->
        Map.update!(resolution, :context, fn ctx ->
          ctx |> Map.delete(:user_id) |> Map.delete(:current_user)
        end)
      end)
    end
  end

  mutation do
    # News
    field :create_post, :post do
      arg(:title, non_null(:string))
      arg(:body, :string)
      arg(:slug, non_null(:string))
      arg(:status, non_null(:string), default_value: "draft")

      resolve(&NewsResolvers.create_post/3)
    end

    field :update_post, :post do
      arg(:post_id, non_null(:id))
      arg(:title, :string)
      arg(:body, :string)
      arg(:slug, :string)
      arg(:status, :string)

      resolve(&NewsResolvers.update_post/3)
    end

    field :delete_post, :post do
      arg(:post_id, non_null(:id))

      resolve(&NewsResolvers.delete_post/3)
    end

    # Accounts
    @desc "Create a new user (for admins only)"
    field :create_user, :user do
      arg(:password, non_null(:string))
      arg(:full_name, non_null(:string))
      arg(:is_admin, :boolean, default_value: false)

      resolve(&AccountsResolvers.create_user/3)
    end

    @desc "Update an existing user (for admins only)"
    field :update_user, :user do
      arg(:user_id, non_null(:id))
      arg(:password, :string)
      arg(:full_name, :string)
      arg(:is_admin, :boolean)

      resolve(&AccountsResolvers.update_user/3)
    end

    field :delete_user, :user do
      arg(:user_id, non_null(:id))

      resolve(&AccountsResolvers.delete_user/3)
    end
  end
end
