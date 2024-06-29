defmodule Lix.Repo.Migrations.ChangeTableName do
  use Ecto.Migration

  def change do
    create table(:username) do
      add :username, :string
    end
  end
end
