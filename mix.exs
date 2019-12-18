defmodule TreeMagic.MixProject do
  use Mix.Project

  def project do
    [
      app: :tree_magic,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      deps: deps(),
      rustler_crates: rustler_crates()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "0.21.0"},
    ]
  end

  defp rustler_crates do
    [
      tree_magic_nif: [
        mode: (if Mix.env() == :prod, do: :release, else: :debug)
      ]
    ]
  end
end
