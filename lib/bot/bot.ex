# defmodule Lix.Supervisor do
#   use Supervisor

#   def start_link() do
#     Supervisor.start_link(__MODULE__, :ok)
#   end

#   @impl true
#   def init(_init_arg) do
#     children = [
#       Lix.Bot
#     ]
#     Supervisor.init(children, strategy: :one_for_one, name: Lix.Bot)
#   end
# end

defmodule Lix.Bot do
  use Nostrum.Consumer

  alias Lix.Repo
  #alias Lix.Twitch

  #@channel_id "#{System.get_env("TEST_CHANNEL_ID")}"
  @channel_id "978163097938317326"
  
  def start_link([]) do
    try do
      Consumer.start_link(__MODULE__)
    rescue
      error ->
        Logger.error("error starting bot: #{inspect(error)}")
    end
  end

  def handle_event({:MESSAGE_CREATE, message, _ws_state}) do
    # cond do
    #   String.starts_with?(message.content, "!track") ->
    #     track_username(message)
    #   true ->
    #     :ignore
    # end
    IO.inspect(message, label: "received message")
    unless message.author.bot do
      spawn fn ->
        Lix.Commands.parse_command(message)
      end
    end
  end

  def handle_event(_event) do
    :noop
  end

  # defp track_username(message) do
  #   username = String.trim_leading(message.content, "!track")

  #   if Repo.get_username(username) do
  #     Nostrum.Api.create_message(@channel_id, "Username #{username} is already being tracked!")
  #   else
  #     Repo.track_username(username)
  #     Nostrum.Api.create_message(@channel_id, "Now tracking Twitch user: #{username}!")
  #   end 
  # end



  # def poll_twitch() do
  #   usernames = Repo.get_all_usernames()

  # end
end
