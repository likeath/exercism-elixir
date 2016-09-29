defmodule Raindrops do
  @dictionary %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    number
    |> find_factors
    |> translate(number)
  end

  defp find_factors(number) do
    @dictionary
    |> Map.keys
    |> Enum.filter(&factor?(number, &1))
  end

  defp factor?(number, candidate) do
    rem(number, candidate) == 0
  end

  defp translate([], number), do: to_string(number)
  defp translate(factors, _) do
    factors
    |> Enum.reduce("", fn(number, result) ->
         result <> Map.fetch!(@dictionary, number)
       end)
  end

end
