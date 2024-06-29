defmodule Lix.Commands do
  alias Nostrum.Api
  alias Lix.Repo

  @channel_id "904126564701200427"

  defp parse_message(message) do
    content = message.content

    unless !String.starts_with?(content, "~") do
      prefixLess = rm(content, "~")
      noExtraSpace = String.replace(prefixLess, ~r/\s+/u, " ")
      [cmd|arg] = String.split(noExtraSpace, ~r/\s+/, parts: 2)
      args = List.first(arg)

      case args do
        nil -> { cmd, nil }
        ag -> {cmd, List.to_tuple(String.split(ag, " "))}
      end

    else
      { nil, content }
    end
  end

  def parse_command(message) do
    case parse_message(message) do
      { nil, _content } -> nil
      { cmd, args } -> exec(cmd, message, args)
    end
  end

  defp rm(full, prefix) do
    bytes = byte_size(prefix)
    <<_::binary-size(bytes), rest::binary>> = full; rest
  end

  # Add commands down here.

  defp exec("ping", message, _args) do
    Api.create_message(message.channel_id, "pong!")
  end
  
  defp exec("pet", message, _args) do
    Api.create_message(message.channel_id, "*bites #{message.member.nick}!*")
  end

  defp exec("noop", message, _args) do
    Api.create_message(message.channel_id, "*panicked bot noises*")
  end

  # defp exec("track", message, _args) do
  #   username = String.trim_leading(message.content, "~track ")

  #   if Repo.get_username(username) do
  #     Api.create_message(@channel_id, "Username #{username} is already being tracked!")
  #   else
  #     Repo.track_username(username)
  #     Api.create_message(@channel_id, "Now tracking Twitch user: #{username}")
  #   end
  # end
  defp exec("track", message, _args) do
    [_command, username] = String.split(message.content, " ", parts: 2) # Split only into command and username

    username = String.trim(username) # Trim any leading/trailing whitespace

    if String.length(username) == 0 do # Handle cases with no username provided
      Api.create_message(message.channel_id, "Please provide a Twitch username to track. Example: !track <username>")
    else
      case Repo.get_username(username) do
        nil ->
          case Repo.track_username(username) do
            {:ok, _user} ->
              Api.create_message(message.channel_id, "Now tracking Twitch user: #{username}")
            {:error, changeset} ->
              error_message = Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end) |> Enum.join(", ")
              Api.create_message(message.channel_id, "Error tracking username: #{error_message}")
          end
        _ ->
          Api.create_message(message.channel_id, "Username #{username} is already being tracked!")
      end
    end
  end

  defp exec(_name, _message, _args) do
  end

end
