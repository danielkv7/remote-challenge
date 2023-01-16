defmodule RemoteChallengeWeb.UserController do
  use RemoteChallengeWeb, :controller

  alias RemoteChallenge.Users

  action_fallback RemoteChallengeWeb.FallbackController

  def index(conn, _params) do
    data = Users.list_users_with_points_higher_than_min_number()
    render(conn, "index.json", %{users: data.users, timestamp: data.timestamp})
  end
end
