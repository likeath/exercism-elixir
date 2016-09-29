defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(&1, base))
  end

  defp anagram?(base, candidate) do
    not_the_same_word?(base, candidate) &&
      (prepared_word(base) === prepared_word(candidate))
  end

  defp not_the_same_word?(first, second) do
    String.downcase(first) != String.downcase(second)
  end

  defp prepared_word(word) do
    word
    |> String.downcase
    |> String.codepoints
    |> Enum.sort
  end

end
