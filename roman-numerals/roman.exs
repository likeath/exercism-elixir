defmodule Roman do
  @roman_numbers %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1_000 => "M"
  }

  @base_numbers Map.keys(@roman_numbers)

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    convert(number)
  end

  defp convert(0), do: ""
  defp convert(number) when number in @base_numbers do
    @roman_numbers[number]
  end
  defp convert(number) do
    base = find_base(number)

    count_needed = div(number, base)
    remainder = rem(number, base)

    numeral = String.duplicate(@roman_numbers[base], count_needed)
    numeral <> convert(remainder)
  end

  defp find_base(number) do
    @roman_numbers
    |> Map.keys
    |> Enum.take_while(fn e -> e < number end)
    |> List.last
  end
end
