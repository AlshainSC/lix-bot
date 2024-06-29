defmodule Lix.Repo.Migrations.CreateUsernames do
  use Ecto.Migration

  def change do
    create table(:usernames) do
      add :username, :string
    end
  end
end
