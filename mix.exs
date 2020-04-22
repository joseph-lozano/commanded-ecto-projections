defmodule Commanded.Projections.Ecto.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :commanded_ecto_projections,
      version: @version,
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: extra_applications(Mix.env())
    ]
  end

  # Include ecto and postgrex apps in `test` environment only
  defp extra_applications(:test), do: [:logger, :ecto, :ecto_sql, :postgrex]
  defp extra_applications(_env), do: [:logger]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp deps do
    [
      {:commanded, github: "joseph-lozano/commanded"},
      {:ecto, "~> 3.2", runtime: false},
      {:ecto_sql, "~> 3.2", runtime: false},
      {:postgrex, ">= 0.0.0", only: :test},

      # Optional dependencies
      {:jason, "~> 1.1", optional: true},

      # Test & build tooling
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Read model projections for Commanded using Ecto.
    """
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit, :ecto],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/commanded_ecto_projections.plt"}
    ]
  end

  defp docs do
    [
      main: "Commanded.Projections.Ecto",
      canonical: "http://hexdocs.pm/commanded_ecto_projections",
      source_ref: "v#{@version}",
      extra_section: "GUIDES",
      extras: [
        "CHANGELOG.md",
        "guides/Getting Started.md",
        "guides/Usage.md"
      ],
      groups_for_extras: [
        Introduction: [
          "guides/Getting Started.md",
          "guides/Usage.md"
        ]
      ]
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        ".formatter.exs",
        "README*",
        "LICENSE*",
        "priv/repo/migrations"
      ],
      maintainers: ["Ben Smith"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/commanded/commanded-ecto-projections"
      }
    ]
  end
end
