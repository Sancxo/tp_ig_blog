defmodule IgBlog.Repo do
  use Ecto.Repo,
    otp_app: :ig_blog,
    adapter: Ecto.Adapters.Postgres
end
