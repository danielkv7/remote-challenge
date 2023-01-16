defmodule RemoteChallenge.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias RemoteChallenge.Users.Processes.UserWorker

  @doc """
  Returns list of users (min 0 and max of 2 users) with points higher then user worker min_number.

  ## Examples

      iex> list_users_with_points_higher_than_min_number()
      {
        timestamp: "2023-01-16 08:14:35",
        users: [
          {id: 999861, points: 64},
          {id: 997247, points: 86 }
        ]
      }

  """
  @spec list_users_with_points_higher_than_min_number :: map()
  def list_users_with_points_higher_than_min_number,
    do: UserWorker.list_users_with_points_higher_than_min_number()
end
