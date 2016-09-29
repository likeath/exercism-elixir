defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> normalize_sentence
    |> split_sentence
    |> count_words
  end

  defp normalize_sentence(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/[^\w-]|_/u, " ")
    |> String.trim
  end

  defp split_sentence(sentence) do
    sentence |> String.split(~r/\s+/)
  end

  defp count_words(words) do
    words
    |> Enum.group_by(fn word -> word end)
    |> Enum.reduce(%{}, fn {word, occurences}, result ->
         Map.put(result, word, length(occurences))
       end)
  end
end
