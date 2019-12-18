defmodule TreeMagic do
  use Rustler, otp_app: :tree_magic, crate: "tree_magic_nif"

  @moduledoc """
  Binding to [tree_magic](https://github.com/aahancoc/tree_magic), providing
  MIME information for files.
  """

  @type mime_type :: binary

  @doc """
  Get the MIME type of a string.

  iex> TreeMagic.from_u8(File.read!("test/fixtures/150.png"))
  "image/png"
  iex> TreeMagic.from_u8(File.read!("test/fixtures/VeryImportant.odt"))
  "application/vnd.oasis.opendocument.text"
  """
  @spec from_u8(binary()) :: mime_type()
  def from_u8(_bytes), do: nif_error()

  @doc """
  Get the MIME type of a file, given its path.

  Will return an error if the file is missing.

  iex> TreeMagic.from_filepath("test/fixtures/150.png")
  {:ok, "image/png"}
  iex> TreeMagic.from_filepath("test/fixtures/VeryImportant.odt")
  {:ok, "application/vnd.oasis.opendocument.text"}
  iex> TreeMagic.from_filepath("missing.png")
  {:error, :enoent}
  """
  @spec from_filepath(Path.t()) :: {:ok, mime_type()} | {:error, term}
  def from_filepath(_path), do: nif_error()

  @doc """
  Determines if a MIME is an alias of another MIME

  If this returns true, that means the two MIME types are equivalent. If this
  returns false, either one of the MIME types are missing, or they are different.

  iex> TreeMagic.is_alias("application/zip", "application/x-zip-compressed")
  true
  """
  @spec is_alias(mime_type(), mime_type()) :: boolean
  def is_alias(_mime1, _mime2), do: nif_error()

  @doc """
  Checks if the given string matches the given MIME type.

  Returns true or false if it matches or not. If the given MIME type is not known,
  the function will always return false. If mimetype is an alias of a known
  MIME, the file will be checked agains that MIME.

  iex> bytes = File.read!("test/fixtures/150.png")
  iex> TreeMagic.match_u8("image/png", bytes)
  true
  iex> TreeMagic.match_u8("application/zip", bytes)
  false
  """
  @spec match_u8(mime_type(), binary()) :: boolean
  def match_u8(_mimetype, _bytes), do: nif_error()

  @doc """
  Check if the given filepath matches the given MIME type.

  If the given MIME type is not known or if the file could not be read, false
  will be returned.

  iex> TreeMagic.match_filepath("image/png", "test/fixtures/150.png")
  true
  iex> TreeMagic.match_filepath("application/zip", "test/fixtures/150.png")
  false
  iex> TreeMagic.match_filepath("image/png", "missing.png")
  false
  """
  @spec match_filepath(mime_type(), Path.t()) :: boolean
  def match_filepath(_mimetype, _path), do: nif_error()

  defp nif_error, do: :erlang.nif_error(:nif_not_loaded)
end
