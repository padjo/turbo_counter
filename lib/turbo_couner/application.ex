defmodule TurboCouner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TurboCouner.Repo,
      # Start the Telemetry supervisor
      TurboCounerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TurboCouner.PubSub},
      # Start the Endpoint (http/https)
      TurboCounerWeb.Endpoint
      # Start a worker by calling: TurboCouner.Worker.start_link(arg)
      # {TurboCouner.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TurboCouner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TurboCounerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
