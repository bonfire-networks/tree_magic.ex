# TreeMagic Elixir

[![CircleCI](https://circleci.com/gh/antoniskalou/tree_magic.ex.svg?style=svg)](https://circleci.com/gh/antoniskalou/tree_magic.ex)

Elixir binding to [tree_magic](https://github.com/aahancoc/tree_magic) for fetching 
MIME information from files and binary data.

## Installation

This package is not available on hex.pm yet, use git instead:

```elixir
# mix.exs

defp dependencies() do
  [
    {:tree_magic, git: "https://github.com/antoniskalou/tree_magic.ex"}
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
