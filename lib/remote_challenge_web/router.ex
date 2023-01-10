defmodule RemoteChallengeWeb.Router do
  use RemoteChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RemoteChallengeWeb do
    pipe_through :api
  end
end
