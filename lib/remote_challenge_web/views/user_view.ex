defmodule RemoteChallengeWeb.UserView do
  use RemoteChallengeWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    timestamp_formatted =
      if timestamp == nil,
        do: nil,
        else: Calendar.strftime(timestamp, "%Y-%m-%d %I:%M:%S")

    %{
      users: Enum.map(users, &%{id: &1.id, points: &1.points}),
      timestamp: timestamp_formatted
    }
  end
end
