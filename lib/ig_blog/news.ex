defmodule IgBlog.News do
  @moduledoc """
  The News context.
  """

  import Ecto.Query, warn: false
  alias IgBlog.Repo

  alias IgBlog.News.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  def list_posts_with_preload, do: list_posts() |> Repo.preload(:user)

  def list_publications do
    Post
    |> where([p], p.status == :published)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_drafts do
    Post
    |> where([p], p.status == :draft)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_posts_by_user(user_id) do
    Post |> where([p], p.author_id == ^user_id) |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_post(id), do: Repo.get(Post, id) |> Repo.preload(:user)

  def get_post_by(query), do: Repo.get_by(Post, query) |> Repo.preload(:user)

  def get_draft_by(query),
    do: Post |> where([p], p.status == :draft) |> Repo.get_by(query) |> Repo.preload(:user)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
