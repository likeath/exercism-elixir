defmodule Grains do
  @base 2
  @max_square 64

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    @base
    |> :math.pow(number - 1)
    |> round
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    square(@max_square) * 2 - 1
  end
end
