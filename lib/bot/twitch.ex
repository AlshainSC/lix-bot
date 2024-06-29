require Logger

defmodule Lix.Twitch do
  @twitch_base_url "https://api.twitch.tv/helix"

  def get_streams(user_logins) do
    headers = [
      {"Client-ID", System.get_env("TWITCH_CLIENT_ID")},
      {"Authorization", "Bearer" <> System.get_env("TWITCH_TOKEN")}
    ]

    url = @twitch_base_url <> "/streams?" <> URI.encode_www_form(%{user_logins: user_logins})

    case Finch.build(:get, url, headers) |> Finch.request(Lix.Finch) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("data", [])

      {:ok, %Finch.Response{status: status, body: body}} ->
        Logger.error("Twitch API error: #{status} - #{body}")
        []

      {:error, reason} ->
        Logger.error("Error fetching stream: #{inspect(reason)}")
        []
    end
  end
end
