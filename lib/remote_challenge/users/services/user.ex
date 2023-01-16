defmodule RemoteChallenge.Users.Services.User do
  import Ecto.Query

  alias RemoteChallenge.Users.Schemas.User
  alias RemoteChallenge.Repo

  @doc """
  Updates all users points with random number from 0 to 100.

  ## Examples

      iex> update_all_users_with_random_points()
      :ok

  """
  @spec update_all_users_with_random_points :: :ok
  def update_all_users_with_random_points() do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

    1..1_000_000
    |> Enum.map(&{&1, Enum.random(0..100)})
    |> Enum.group_by(
      fn {_id, random_number} -> random_number end,
      fn {id, _random_number} -> id end
    )
    |> Enum.map(fn {random_number, ids} ->
      Task.async(fn ->
        User
        |> where([u], u.id in ^ids)
        |> Repo.update_all(set: [points: random_number, updated_at: now])
      end)
    end)
    |> Enum.each(&Task.await(&1))

    :ok
  end

  @doc """
  Returns list of users (min 0 and max of 2 users) with points higher then user worker min_number.

  ## Examples

      iex> list_users_with_points_higher_than_number()
      [%User{}...]

  """
  @spec list_users_with_points_higher_than_number(number :: integer) :: [User.t()]
  def list_users_with_points_higher_than_number(number) do
    User
    |> where([u], u.points > ^number)
    |> select([u], %{id: u.id, points: u.points})
    |> limit(2)
    |> Repo.all()
  end
end
