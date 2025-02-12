defmodule IgBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fullname, :string
      add :password, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
