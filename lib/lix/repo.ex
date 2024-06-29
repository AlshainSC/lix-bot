defmodule Lix.Repo do
  use Ecto.Repo,
    otp_app: :src,
    adapter: Ecto.Adapters.Postgres

  def get_all_usernames() do
    Lix.Username |> Lix.Repo.all()
  end
  
  def get_username(username) do
    Lix.Username |> Lix.Repo.get_by(Username, username: username)
  end

  def track_username(username) do
    Lix.Repo.insert(username)
  end
end
