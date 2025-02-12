defmodule IgBlogWeb.Resolvers do
  alias IgBlog.Accounts
  alias IgBlog.Accounts.User
  alias IgBlog.News

  def list_posts(%Accounts.User{id: user_id}, _arg, _infos) do
    {:ok, News.list_posts_by_user(user_id)}
  end

  def list_publications(_parent, _args, %{context: %{current_user: %User{}}}) do
    {:ok, News.list_publications()}
  end

  def list_publications(_parent, _args, _) do
    {:error, "Unauthorized (you are not logged in)"}
  end

  def list_drafts(_parent, _args, %{context: %{current_user: %User{is_admin: true}}}) do
    {:ok, News.list_drafts()}
  end

  def list_drafts(_parent, _args, _) do
    {:error, "Unauthorized (you are not identified as 'admin')"}
  end

  def get_post(_, args, _) do
    {:ok, News.get_post_by(args)}
  end

  def get_draft(_, args, %{context: %{current_user: %User{is_admin: true}}}) do
    {:ok, News.get_draft_by(args)}
  end

  def get_draft(_, _, _) do
    {:error, "Unauthorized (you are not identified as 'admin')"}
  end

  def create_post(_, args, %{context: %{current_user: %User{is_admin: true}}}) do
    args =
      args |> Map.put_new(:published_at, DateTime.utc_now())

    News.create_post(args)
  end

  def get_user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  def log_in(_, args, _) do
    {:ok, Accounts.get_user_by(args)}
  end

  def log_out(_, _, %{context: %{current_user: %{id: user_id}}}) do
    {:ok, Accounts.get_user!(user_id)}
  end
end
