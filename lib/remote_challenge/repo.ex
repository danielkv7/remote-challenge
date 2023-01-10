defmodule RemoteChallenge.Repo do
  use Ecto.Repo,
    otp_app: :remote_challenge,
    adapter: Ecto.Adapters.Postgres
end
