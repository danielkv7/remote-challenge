defmodule RemoteChallenge.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps()
    end

    create constraint("users", "points_must_be_between_0_and_100",
             check: "points BETWEEN 0 and 100",
             comment: "Points must be between 0 and 100"
           )
  end
end
