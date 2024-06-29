import Config

config :src, Lix.Repo,
  database: "lix_twitch",
  username: "alshain",
  password: "",
  hostname: "127.0.0.1"

config :src, ecto_repos: [Lix.Repo]

config :nostrum,
  token: System.get_env("LIX_TOKEN") ,
  gateway_intents: [
    :guilds,
    :guild_messages,
    :message_content
  ] 



