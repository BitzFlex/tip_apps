# mix.exs first line

defmodule TipApps.MixProject do
  use Mix.Project

  def project do
    [
      app: :tip_apps,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TipApps, []},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:distillery, "~> 2.0"},
      {:pigeon, "~> 1.3"}, {:kadabra, "~> 0.4.3"},
      {:gcm, "~> 1.5"},
      {:benchee, "~> 1.0"},
      {:gen_smtp, "~> 1.1"},
      {:mongodb_driver, "~> 0.7.1"},
      {:amqp, "~> 2.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
