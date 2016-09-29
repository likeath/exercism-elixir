defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    case do_generate(amount, values, %{}) do
      {:halted, result} -> {:ok, result}
      _ -> :error
    end
  end

  defp do_generate(_amount, [], _), do: :error

  defp do_generate(amount, coins, acc) do
    coins
    |> prepare_coins
    |> Enumerable.reduce({:cont, acc}, fn coin, map_of_coins ->
      remainder = amount - coin

      cond do
        remainder > 0 ->
          case do_generate(remainder, coins, increment_coin_count(map_of_coins, coin)) do
            {:halted, result} -> {:halt, result}
            {:done, _} -> {:cont, no_coins(%{}, coin)}
          end
        remainder == 0 ->
          {:halt, increment_coin_count(map_of_coins, coin)}
        remainder <= 0 ->
          {:cont, no_coins(map_of_coins, coin)}
      end
    end)
  end

  defp prepare_coins(coins) do
    coins
    |> Enum.sort
    |> Enum.reverse
  end

  defp increment_coin_count(map_of_coins, coin) do
    map_of_coins
    |> Map.update(coin, 1, &(&1 + 1))
  end

  defp no_coins(map_of_coins, coin) do
    map_of_coins
    |> Map.put_new(coin, 0)
  end
end
