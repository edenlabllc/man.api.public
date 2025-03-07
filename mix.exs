defmodule Man.MixProject do
  use Mix.Project

  @version "2.7.1"
  def project do
    [
      version: @version,
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        filter_prefix: "*.Rpc"
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:git_ops, "~> 0.6.0", only: [:dev]},
      {:distillery, "~> 2.0", runtime: false, override: true},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.8.1", only: [:dev, :test]},
      {:ex_doc, "~> 0.20.2", only: :dev, runtime: false}
    ]
  end
end
