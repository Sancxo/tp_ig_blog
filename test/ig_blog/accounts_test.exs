defmodule IgBlog.AccountsTest do
  use IgBlog.DataCase

  alias IgBlog.Accounts

  describe "users" do
    alias IgBlog.Accounts.User

    import IgBlog.AccountsFixtures

    @invalid_attrs %{password: nil, fullname: nil, is_admin: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{password: "some password", fullname: "some fullname", is_admin: true}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.password == "some password"
      assert user.fullname == "some fullname"
      assert user.is_admin == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{password: "some updated password", fullname: "some updated fullname", is_admin: false}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.password == "some updated password"
      assert user.fullname == "some updated fullname"
      assert user.is_admin == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
