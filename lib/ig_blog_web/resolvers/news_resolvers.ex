defmodule IgBlogWeb.Resolvers.NewsResolvers do
  alias IgBlog.Accounts.User
  alias IgBlog.News

  def list_posts(%User{id: user_id}, _arg, _infos) do
    {:ok, News.list_posts_by_user(user_id)}
  end

  def list_publications(_parent, _args, %{context: %{current_user: %User{}}}) do
    {:ok, News.list_publications()}
  end

  def list_publications(_parent, _args, _), do: {:error, "Unauthorized (you are not logged in)"}

  def list_drafts(_parent, _args, %{context: %{current_user: %User{is_admin: true}}}) do
    {:ok, News.list_drafts()}
  end

  def list_drafts(_parent, _args, _),
    do: {:error, "Unauthorized (you are not logged in or not identified as 'admin')"}

  def get_post(_, args, %{context: %{current_user: %User{}}}) do
    {:ok, News.get_post_by(args)}
  end

  def get_post(_, _, _), do: {:error, "Unauthorized (you are not logged in)"}

  def get_draft(_, args, %{context: %{current_user: %User{is_admin: true}}}) do
    {:ok, News.get_draft_by(args)}
  end

  def get_draft(_, _, _), do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def create_post(_, args, %{context: %{current_user: %User{id: user_id, is_admin: true}}}) do
    args =
      args
      |> Map.put_new(:published_at, DateTime.utc_now())
      |> Map.put_new(:author_id, user_id)

    News.create_post(args)
  end

  def create_post(_, _, _), do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def update_post(_, %{post_id: id} = args, %{context: %{current_user: %User{is_admin: true}}}) do
    id
    |> News.get_post!()
    |> News.update_post(args)
  end

  def update_post(_, _, _), do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def delete_post(_, %{post_id: id}, %{context: %{current_user: %User{is_admin: true}}}) do
    id
    |> News.get_post!()
    |> News.delete_post()
  end

  def delete_post(_, _, _), do: {:error, "Unauthorized (you are not identified as 'admin')"}
end
