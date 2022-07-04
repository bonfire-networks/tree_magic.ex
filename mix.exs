defmodule TreeMagic.MixProject do
  use Mix.Project

  def project do
    [
      app: :tree_magic,
      version: "0.1.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: [ extra_applications: [:logger] ]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.22.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      name: "tree_magic",
      description: "Binding to tree_magic, providing MIME information for files.",
      licenses: ["LGPL-3.0-only"],
      homepage_url: "https://github.com/bonfire-networks/tree_magic.ex",
      links: %{
        "GitHub" => "https://github.com/bonfire-networks/tree_magic.ex",
        "CommonsPub" => "https://github.com/bonfire-networks",
      }
    ]
  end
end
