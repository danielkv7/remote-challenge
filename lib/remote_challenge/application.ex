defmodule RemoteChallenge.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RemoteChallenge.Repo,
      RemoteChallengeWeb.Telemetry,
      {Phoenix.PubSub, name: RemoteChallenge.PubSub},
      RemoteChallengeWeb.Endpoint,
      RemoteChallenge.Users.Processes.UserWorker
    ]

    opts = [strategy: :one_for_one, name: RemoteChallenge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    RemoteChallengeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
