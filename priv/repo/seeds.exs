alias RemoteChallenge.Repo
alias RemoteChallenge.Users.Schemas.User

total_users_to_insert = 1_000_000
amount_params_database_can_handle = 65535

now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
user_params_to_insert = %{points: 0, inserted_at: now, updated_at: now}

users_chunk_size_to_insert =
  div(amount_params_database_can_handle, Enum.count(user_params_to_insert))

Enum.map(1..total_users_to_insert, fn _num -> user_params_to_insert end)
|> Enum.chunk_every(users_chunk_size_to_insert)
|> Enum.map(&Task.async(fn -> Repo.insert_all(User, &1) end))
|> Enum.each(&Task.await(&1))
