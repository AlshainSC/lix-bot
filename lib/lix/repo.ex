defmodule Lix.Repo do
  use Ecto.Repo,
    otp_app: :src,
    adapter: Ecto.Adapters.Postgres
  import Ecto.Query

  def get_all_usernames() do
    Lix.Username
    |> Lix.Repo.all()
    |> Enum.map(& &1.username)
  end
  
  def get_username(username) do
    query = from u in Lix.Username,
      where: u.username == ^username

    Lix.Repo.one(query)
  end

  def track_username(username) do
    # Lix.Repo.insert(username)
    %Lix.Username{username: username}
    |> Lix.Repo.insert()
  end
end
