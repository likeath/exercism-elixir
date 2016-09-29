defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> to_symobols
    |> uniq_symbols?
  end

  defp to_symobols(sentence) do
    sentence
    |> String.replace(~r/[^[:alpha:]]/u, "")
    |> String.codepoints
  end

  defp uniq_symbols?(sentence) do
    Enum.uniq(sentence) == sentence
  end
end
