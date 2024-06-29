import Config

config :src, Lix.Repo,
  database: System.get_env("DATABASE_NAME"), 
  username: System.get_env("USERNAME"),
  password: System.get_env("PASSWORD"),
  hostname: System.get_env("HOSTNAME"),
  template: "postgres"

config :src, ecto_repos: [Lix.Repo]

config :nostrum,
  token: System.get_env("LIX_TOKEN") ,
  gateway_intents: [
    :guilds,
    :guild_messages,
    :message_content
  ] 



