defmodule Src.MixProject do
  use Mix.Project

  def project do
    [
      app: :src,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Src.Application, []},
      extra_applications: [:logger, :runtime_tools ],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.18.0"},
      {:jason, "~> 1.4"},
      {:ex_twitch, "~> 0.0.1"},
      {:nostrum, "~> 0.9.1"},
      {:postgrex, "~> 0.15"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:dotenvy, "~> 0.8.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
