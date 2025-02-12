defmodule IgBlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string, redact: true
    field :fullname, :string
    field :is_admin, :boolean, default: false

    has_many :posts, IgBlog.News.Post, foreign_key: :author_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fullname, :password, :is_admin])
    |> validate_required([:fullname, :password, :is_admin])
  end
end
