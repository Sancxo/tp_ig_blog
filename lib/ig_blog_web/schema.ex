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

    @desc "Get all draft posts (for admins only)"
    field :list_drafts, list_of(:post) do
      resolve(&NewsResolvers.list_drafts/3)
    end

    @desc "Search inside the title, slug and body of a published post."
    field :search_publications, list_of(:post) do
      arg(:term, :string)
      resolve(&NewsResolvers.search_publications/3)
    end

    @desc "Get a single published post from its slug"
    field :get_publication, :post do
      arg(:slug, non_null(:string))
      resolve(&NewsResolvers.get_post/3)
    end

    @desc "Get a single draft post from its slug (for admins only)"
    field :get_draft, :post do
      arg(:slug, non_null(:string))
      resolve(&NewsResolvers.get_draft/3)
    end

    # Accounts
    @desc "List all users"
    field :list_users, list_of(:user) do
      resolve(&AccountsResolvers.list_users/3)
    end

    @desc "Get a single user from its id"
    field :get_user, :user do
      arg(:id, non_null(:id))
      resolve(&AccountsResolvers.get_user/3)
    end
  end

  mutation do
    # News
    @desc "Creates a post (for admins only)"
    field :create_post, :post do
      arg(:title, non_null(:string))
      arg(:body, :string)
      arg(:slug, non_null(:string))
      arg(:status, non_null(:string), default_value: "draft")

      resolve(&NewsResolvers.create_post/3)
    end

    @desc "Updates a post (for admins only)"
    field :update_post, :post do
      arg(:post_id, non_null(:id))
      arg(:title, :string)
      arg(:body, :string)
      arg(:slug, :string)
      arg(:status, :string)

      resolve(&NewsResolvers.update_post/3)
    end

    @desc "Deletes a post (for admins only)"
    field :delete_post, :post do
      arg(:post_id, non_null(:id))

      resolve(&NewsResolvers.delete_post/3)
    end

    # Accounts
    @desc "Logs a user in and returns its data"
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

    @desc "Logs a user out and returns its data"
    field :log_out, :user do
      resolve(&AccountsResolvers.log_out/3)

      middleware(fn resolution, _ ->
        Map.update!(resolution, :context, fn ctx ->
          ctx |> Map.delete(:user_id) |> Map.delete(:current_user)
        end)
      end)
    end

    @desc "Create a new user (for admins only)"
    field :create_user, :user do
      arg(:password, non_null(:string))
      arg(:fullname, non_null(:string))
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

    @desc "Deletes a user (for admins only)"
    field :delete_user, :user do
      arg(:user_id, non_null(:id))

      resolve(&AccountsResolvers.delete_user/3)
    end
  end
end
