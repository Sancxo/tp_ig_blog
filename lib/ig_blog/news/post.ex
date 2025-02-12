defmodule IgBlog.News.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:status, Ecto.Enum, values: [:draft, :published])
    field :title, :string
    field :body, :string
    field :published_at, :utc_datetime
    field(:slug)

    belongs_to(:user, IgBlog.Accounts.User, foreign_key: :author_id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :status, :published_at, :slug, :author_id])
    |> validate_required([:title, :body, :status, :published_at, :slug])
    |> unique_constraint(:slug)
  end
end
