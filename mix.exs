defmodule CliConversor.MixProject do
  use Mix.Project

  def project do
    [
      app: :cli_conversor,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CliConversor.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:hackney, "~> 1.17"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"}
    ]
  end
end
