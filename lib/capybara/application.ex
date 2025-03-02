defmodule Capybara.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CapybaraWeb.Telemetry,
      Capybara.Repo,
      {DNSCluster, query: Application.get_env(:capybara, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Capybara.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Capybara.Finch},
      # Start a worker by calling: Capybara.Worker.start_link(arg)
      # {Capybara.Worker, arg},
      # Start to serve requests, typically the last entry
      CapybaraWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Capybara.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CapybaraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
