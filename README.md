# TreeMagic Elixir

[![CircleCI](https://circleci.com/gh/antoniskalou/tree_magic.ex.svg?style=svg)](https://circleci.com/gh/antoniskalou/tree_magic.ex)

Elixir binding to [tree_magic](https://github.com/aahancoc/tree_magic) for fetching 
MIME information from files and binary data.

## Installation

Recommended installation is through Hex:

```elixir
# mix.exs

defp dependencies() do
  [
    {:tree_magic, "~> 0.1.0"}
  ]
end
```

To use the latest development version:

```elixir
# mix.exs

defp dependencies() do
  [
    {:tree_magic, git: "https://github.com/bonfire-networks/tree_magic.ex"}
  ]
end
```

## Quickstart

See documentation for more information.

```elixir
iex> TreeMagic.from_filepath("image.png")
"image/png"
iex> TreeMagic.from_u8(charlist)
"image/png"
```

## License

LGPLv3 License, see [LICENSE](LICENSE).
