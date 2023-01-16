# Remote challenge

To start your Phoenix server locally as development environment:

- Make sure you have Erlang and Elixir installed
- Setup database:
  - To use postgresql through docker run following command: `docker run --name remote-challenge-postgresql -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres -c max_connections=150`
  - If you won't use docker, you should configure your Postgres database to accept connections on port 5432 and configure a user as `postgres` with password `postgres`
- Install dependencies with `mix deps.get`
- Create, migrate and seed your database with `mix ecto.setup`
- Start Phoenix server with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can go to [`localhost:4000`](http://localhost:4000) from any HTTP client to fetch users (min of 0 max of 2 users list) with points higher than min_number from User's GenServer. Remember that every minute, from the start of the Phoenix server, all users will have their points updated with random numbers.
