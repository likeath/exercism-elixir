defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.flat_map(&invert/1)
    |> Enum.into(%{})
  end

  defp invert({score, words}) do
    words
    |> Enum.map(fn word ->
         {String.downcase(word), score}
       end)
  end
end
