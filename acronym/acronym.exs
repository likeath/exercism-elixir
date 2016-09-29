defmodule Acronym do
  @split_regex [
    _upper_letters_followed_by_lower = "(?=[[:upper:]]+[[:lower:]]?)",
    _spaces = "\\s+",
    ",",
    "-"
  ] |> Enum.join("|") |> Regex.compile!

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(@split_regex, trim: true)
    |> Enum.map(&String.first/1)
    |> Enum.join
    |> String.upcase
  end
end
