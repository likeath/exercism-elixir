defmodule RunLengthEncoder do
  @encode_split_regex ~r/(\D)\1*/
  @decode_split_regex ~r/(\d+)([[:alpha:]])/

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    Regex.scan(@encode_split_regex, string)
    |> Enum.map_join(&encode_chunk/1)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(@decode_split_regex, string, capture: :all_but_first)
    |> Enum.map_join(&decode_chunk/1)
  end

  defp encode_chunk([occurences, letter]) do
    "#{ String.length(occurences) }#{ letter }"
  end

  defp decode_chunk([occurences_count, letter]) do
    { count, _ } = Integer.parse(occurences_count)
    String.duplicate(letter, count)
  end
end
