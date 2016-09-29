defmodule Bob do
  @letter_regexp ~r/[[:alpha:]]/

  #  def hey(input) do
  #    cond do
  #      String.ends_with?(input, "?") -> "Sure."
  #      String.trim(input) == "" -> "Fine. Be that way!"
  #      String.upcase(input) == input && Regex.match?(@letter_regexp, String.downcase(input)) -> "Whoa, chill out!"
  #      true -> "Whatever."
  #    end
  #  end

  def hey(input) do
    input
    |> interpret_message
    |> respond_to_message
  end

  defp interpret_message(message) do
    cond do
      String.ends_with?(message, "?")
        -> :question
      String.trim(message) == ""
        -> :silence
      String.upcase(message) == message && String.downcase(message) != message
        -> :shouting
      :else
        -> :anything
    end
  end

  defp respond_to_message(:question), do: "Sure."
  defp respond_to_message(:shouting), do: "Whoa, chill out!"
  defp respond_to_message(:silence),  do: "Fine. Be that way!"
  defp respond_to_message(_anything), do: "Whatever."
end
