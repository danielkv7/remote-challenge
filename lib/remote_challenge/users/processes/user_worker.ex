defmodule RemoteChallenge.Users.Processes.UserWorker do
  use GenServer

  alias RemoteChallenge.Users.Services.User, as: UserService

  ##########
  # Client #
  ##########
  def start_link(args, opts \\ []),
    do: GenServer.start_link(__MODULE__, args, [name: __MODULE__] ++ opts)

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

  ###########
  # Helpers #
  ###########

  defp schedule_update_users_points_and_min_number_with_random_number() do
    # 1 minute
    Process.send_after(self(), :update_users_points_and_min_number_with_random_number, 60 * 1000)
  end
end
