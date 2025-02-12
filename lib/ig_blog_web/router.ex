defmodule IgBlogWeb.Router do
  use IgBlogWeb, :router

  alias IgBlogWeb.Context

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug Context
  end

  scope "/api" do
    pipe_through :api

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: IgBlogWeb.Schema,
      context: %{pubsub: IgBlogWeb.Endpoint},
      before_send: {Context, :before_send}
    )
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ig_blog, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: IgBlogWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
