defmodule RemoteChallengeWeb.Router do
  use RemoteChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RemoteChallengeWeb do
    pipe_through :api

    get "/", UserController, :index
  end
end
