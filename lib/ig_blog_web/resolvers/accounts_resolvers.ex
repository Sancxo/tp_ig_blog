defmodule IgBlogWeb.Resolvers.AccountsResolvers do
  alias IgBlog.Accounts.User
  alias IgBlog.Accounts

  def list_users(_, _, %{context: %{current_user: %User{is_admin: true}}}) do
    {:ok, Accounts.list_users()}
  end

  def list_users(_parent, _args, _infos),
    do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def get_user(_, %{id: id}, %{context: %{current_user: %User{}}}) do
    {:ok, Accounts.get_user!(id)}
  end

  def get_user(_parent, _args, _infos),
    do: {:error, "Unauthorized (you are not logged in)"}

  def create_user(_parent, args, %{context: %{current_user: %User{is_admin: true}}}) do
    Accounts.create_user(args)
  end

  def create_user(_parent, _args, _infos),
    do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def update_user(_parent, %{user_id: id} = args, %{
        context: %{current_user: %User{is_admin: true}}
      }) do
    id
    |> Accounts.get_user!()
    |> Accounts.update_user(args)
  end

  def update_user(_parent, _args, _infos),
    do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def delete_user(_, %{user_id: id}, %{context: %{current_user: %User{is_admin: true}}}) do
    id
    |> Accounts.get_user!()
    |> Accounts.delete_user()
  end

  def delete_user(_, _, _), do: {:error, "Unauthorized (you are not identified as 'admin')"}

  def log_in(_, args, _), do: {:ok, Accounts.get_user_by(args)}

  def log_out(_, _, %{context: %{current_user: %User{id: user_id}}}) do
    {:ok, Accounts.get_user!(user_id)}
  end

  def log_out(_parent, _args, _infos),
    do: {:error, "Unauthorized (you are not logged in)"}
end
