defmodule IgBlog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IgBlogWeb.Telemetry,
      IgBlog.Repo,
      {DNSCluster, query: Application.get_env(:ig_blog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: IgBlog.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: IgBlog.Finch},
      # Start a worker by calling: IgBlog.Worker.start_link(arg)
      # {IgBlog.Worker, arg},
      # Start to serve requests, typically the last entry
      IgBlogWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IgBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IgBlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
