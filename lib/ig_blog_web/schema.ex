defmodule IgBlogWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(IgBlogWeb.Types)

  alias IgBlogWeb.Resolvers
  alias IgBlog.Accounts.User

  query do
    @desc "Get all published posts"
    field :list_publications, list_of(:post) do
      resolve(&Resolvers.list_publications/3)
    end

    field :list_draft, list_of(:post) do
      resolve(&Resolvers.list_drafts/3)
    end

    field :get_post, :post do
      arg(:slug, non_null(:string))
      resolve(&Resolvers.get_post/3)
    end

    field :get_user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.get_user/3)
    end

    field :log_in, :user do
      arg(:fullname, :string)
      arg(:password, :string)
      resolve(&Resolvers.log_in/3)

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
      resolve(&Resolvers.log_out/3)

      middleware(fn resolution, _ ->
        Map.update!(resolution, :context, fn ctx ->
          ctx |> Map.delete(:user_id) |> Map.delete(:current_user)
        end)
      end)
    end
  end

  # mutation do

  # end
end
