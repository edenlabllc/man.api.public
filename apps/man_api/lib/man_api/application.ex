defmodule Man do
  @moduledoc """
  This is an entry point of Man application.
  """
  use Application
  alias Confex.Resolver
  alias Man.Web.Endpoint

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Start cache supervisor
      supervisor(Man.Cache.Supervisor, []),
      # Start the Ecto repository
      supervisor(Man.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Endpoint, [])
      # Starts a worker by calling: Man.Worker.start_link(arg1, arg2, arg3)
      # worker(Man.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: Man.Supervisor]
    :telemetry.attach("log-handler", [:man, :repo, :query], &Man.TelemetryHandler.handle_event/4, nil)
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end

  # Loads configuration in `:on_init` callbacks and replaces `{:system, ..}` tuples via Confex
  @doc false
  def load_from_system_env(config) do
    {:ok, Resolver.resolve(config)}
  end
end
