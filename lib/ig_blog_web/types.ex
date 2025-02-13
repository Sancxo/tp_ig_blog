defmodule IgBlogWeb.Types do
  use Absinthe.Schema.Notation
  alias IgBlogWeb.Resolvers.NewsResolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :password, :string
    field :fullname, :string
    field :is_admin, :boolean

    field :posts, list_of(:post) do
      resolve(&NewsResolvers.list_posts/3)
    end
  end

  enum :post_status do
    value(:draft)
    value(:published)
  end

  @desc "A blog post"
  object :post do
    field :id, :id
    field :title, :string
    field :body, :string

    field :slug, :string, description: "A lowercase string without spaces to be used as post path"

    field :status, :post_status
    field :published_at, :naive_datetime
    field :user, :user
  end
end
