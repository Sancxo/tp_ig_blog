defmodule IgBlogWeb.Context do
  @behaviour Plug
  import Plug.Conn

  alias IgBlog.Accounts.User
  alias IgBlog.Repo

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _) do
    Absinthe.Plug.put_options(conn, context: build_context(conn))
  end

  def before_send(
        %Plug.Conn{} = conn,
        %Absinthe.Blueprint{execution: %{context: context}}
      ) do
    is_connected = get_session(conn, :user_id)

    cond do
      # we received an user_id from the :log_in mutation or the current_user and user_id is not inside session
      (context[:user_id] || context[:current_user]) && !is_connected ->
        put_session(conn, :user_id, context[:user_id])

      # the user_id was deleted from context by the :log_out mutation and the cookie already has user_id inside session
      !context[:user_id] && !context[:current_user] && is_connected ->
        delete_session(conn, :user_id)

      true ->
        conn
    end
  end

  def before_send(conn, _), do: conn

  defp build_context(conn) do
    with user_id when not is_nil(user_id) <- get_session(conn, :user_id),
         {:ok, user} <- authorize(user_id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp authorize(user_id) do
    User
    |> Repo.get(user_id)
    |> case do
      nil ->
        {:error, "Unauthorized"}

      user ->
        {:ok, user}
    end
  end
end
