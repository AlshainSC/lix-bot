defmodule Src.Application do
  use Application
  @impl true
  def start(_type, _args) do
    # Lix.Supervisor.start_link
    children = [
        Lix.Repo,
        Lix.Bot
      ]
    opts = [strategy: :one_for_one, name: Src.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

