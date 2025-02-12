defmodule IgBlog.NewsTest do
  use IgBlog.DataCase

  alias IgBlog.News

  describe "posts" do
    alias IgBlog.News.Post

    import IgBlog.NewsFixtures

    @invalid_attrs %{status: nil, title: nil, body: nil, published_at: nil, slug: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert News.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert News.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{status: :draft, title: "some title", body: "some body", published_at: ~U[2025-02-11 09:32:00Z], slug: "some slug"}

      assert {:ok, %Post{} = post} = News.create_post(valid_attrs)
      assert post.status == :draft
      assert post.title == "some title"
      assert post.body == "some body"
      assert post.published_at == ~U[2025-02-11 09:32:00Z]
      assert post.slug == "some slug"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = News.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{status: :published, title: "some updated title", body: "some updated body", published_at: ~U[2025-02-12 09:32:00Z], slug: "some updated slug"}

      assert {:ok, %Post{} = post} = News.update_post(post, update_attrs)
      assert post.status == :published
      assert post.title == "some updated title"
      assert post.body == "some updated body"
      assert post.published_at == ~U[2025-02-12 09:32:00Z]
      assert post.slug == "some updated slug"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = News.update_post(post, @invalid_attrs)
      assert post == News.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = News.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> News.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = News.change_post(post)
    end
  end
end
