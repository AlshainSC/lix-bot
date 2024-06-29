
defmodule Lix.Bot do
  use Nostrum.Consumer

  alias Lix.Twitch
  alias Lix.Repo
  @channel_id "904126564701200427"

  def start_link([]) do
    try do
      Consumer.start_link(__MODULE__)
    rescue
      error ->
        Logger.error("error starting bot: #{inspect(error)}")
    end
  end

  def handle_event({:MESSAGE_CREATE, message, _ws_state}) do
   IO.inspect(message, label: "received message")
    unless message.author.bot do
      spawn fn ->
        Lix.Commands.parse_command(message)
      end
    end
  end

  def poll_twitch() do
    users = Repo.get_all_usernames()

    users
    |> Enum.chunk_every(100)
    |> Task.async_stream(&Twitch.get_streams/1)
    |> Enum.flat_map(fn {:ok, streams} -> streams end)
    |> Enum.each(fn stream ->
      if stream["type"] == "live" do
        user = Repo.get_username(stream["user_name"])
        if user do
          Nostrum.Api.create_message(@channel_id, "#{user.username} has gone live on Twitch! https://twitch.tv/#{user.username}")
        end
      end
    end)
  end

  def handle_event(_event) do
    :noop
  end
end
