defmodule BracketPush do
  @brackets_content_regex [
    _square_brackets = "\\[([^\\[]*)\\]",
    _curly_brackets  = "{([^{]*)}",
    _common_brackets = "\\(([^\\(]*)\\)"
  ] |> Enum.join("|") |> Regex.compile!

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(""), do: true
  def check_brackets(string) do
    string
    |> get_brackets_content
    |> valid_brackets_content?
  end

  defp get_brackets_content(string) do
    Regex.run(@brackets_content_regex, string, capture: :all_but_first)
  end

  defp valid_brackets_content?(nil), do: false
  defp valid_brackets_content?(brackets_content) do
    brackets_content
    |> Enum.all?(&(check_brackets/1))
  end
end
