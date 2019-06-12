defmodule Man.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :man_api,
      version: "0.1.0",
      package: package(),
      elixir: "~> 1.8.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["../../README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {Man, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:confex_config_provider, "~> 0.1.0"},
      {:confex, "~> 3.4"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, "~> 0.14.1"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.7"},
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.2"},
      {:phoenix, "~> 1.4.0"},
      {:eview, "~> 0.15.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:scrivener_ecto, git: "https://github.com/AlexKovalevych/scrivener_ecto.git", branch: "fix_page_number"},
      {:nex_json_schema, ">= 0.7.2"},
      {:bbmustache, "~> 1.4"},
      {:earmark, "~> 1.2"},
      {:pdf_generator, "~> 0.3.5"},
      {:ehealth_logger, git: "https://github.com/edenlabllc/ehealth_logger.git"},
      {:kube_rpc, "~> 0.3.0"}
    ]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [
      contributors: ["Nebo #15"],
      maintainers: ["Nebo #15"],
      licenses: ["LISENSE.md"],
      links: %{github: "https://github.com/Nebo15/man.api"},
      files: ~w(lib LICENSE.md mix.exs README.md)
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
