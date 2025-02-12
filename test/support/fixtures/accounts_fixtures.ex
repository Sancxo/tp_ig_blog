defmodule IgBlog.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgBlog.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        fullname: "some fullname",
        is_admin: true,
        password: "some password"
      })
      |> IgBlog.Accounts.create_user()

    user
  end
end
