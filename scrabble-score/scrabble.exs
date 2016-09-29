defmodule Scrabble do
  @scores %{
    ~w(A E I O U L N R S T) => 1,
    ~w(D G)                 => 2,
    ~w(B C M P)             => 3,
    ~w(F H V W Y)           => 4,
    ~w(K)                   => 5,
    ~w(J X)                 => 8,
    ~w(Q Z)                 => 10
  }

  @letters_modifiers %{
    ~w(Q J) => 1,
    ~w(G W) => 2
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t, Integer.t) :: non_neg_integer
  def score(word, word_modifier \\ 1) do
    word
    |> to_letters
    |> count_scores
    |> apply_modifier(word_modifier)
  end

  defp to_letters(word) do
    word
    |> String.trim
    |> String.upcase
    |> String.codepoints
  end

  defp count_scores([]), do: 0
  defp count_scores(letters) do
    letters
    |> Enum.map(&score_for_letter/1)
    |> Enum.sum
  end

  defp score_for_letter(letter) do
    @scores
    |> find_value_for(letter)
    |> apply_letter_modifier(letter)
  end

  defp apply_letter_modifier(score, letter) do
    apply_modifier(
      score,
      find_value_for(@letters_modifiers, letter, 1)
    )
  end

  defp apply_modifier(score, modifier) do
    score * modifier
  end

  # TODO: better name
  defp find_value_for(map, key, default \\ 0) do
    Enum.find_value(map, default, fn {keys, value} ->
      Enum.member?(keys, key) && value
    end)
  end
end
