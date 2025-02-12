defmodule IgBlog.NewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgBlog.News` context.
  """

  @doc """
  Generate a unique post slug.
  """
  def unique_post_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        published_at: ~U[2025-02-11 09:32:00Z],
        slug: unique_post_slug(),
        status: :draft,
        title: "some title"
      })
      |> IgBlog.News.create_post()

    post
  end
end
