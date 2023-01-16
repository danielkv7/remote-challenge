defmodule RemoteChallenge.Users.Processes.UserWorker do
  use GenServer

  alias RemoteChallenge.Users.Services.User, as: UserService

  ##########
  # Client #
  ##########
  def start_link(args, opts \\ []),
    do: GenServer.start_link(__MODULE__, args, [name: __MODULE__] ++ opts)

  def list_users_with_points_higher_than_min_number(),
    do: GenServer.call(__MODULE__, :list_users_with_points_higher_than_min_number)

  ######################
  # Server (callbacks) #
  ######################

  @impl true
  def init(_args) do
    schedule_update_users_points_and_min_number_with_random_number()

    {:ok, %{min_number: 0, timestamp: nil}}
  end

  @impl true
  def handle_info(:update_users_points_and_min_number_with_random_number, state) do
    :ok = UserService.update_all_users_with_random_points()

    schedule_update_users_points_and_min_number_with_random_number()

    {:noreply, Map.put(state, :min_number, Enum.random(0..100))}
  end

  @impl true
  def handle_call(:list_users_with_points_higher_than_min_number, _from, state) do
    users = UserService.list_users_with_points_higher_than_number(state.min_number)
    timestamp = state.timestamp

    state_with_timestamp_updated = Map.put(state, :timestamp, NaiveDateTime.utc_now())

    {:reply, %{users: users, timestamp: timestamp}, state_with_timestamp_updated}
  end

  ###########
  # Helpers #
  ###########

  defp schedule_update_users_points_and_min_number_with_random_number() do
    # 1 minute
    Process.send_after(self(), :update_users_points_and_min_number_with_random_number, 60 * 1000)
  end
end
