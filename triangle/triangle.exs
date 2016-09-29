defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }

  def kind(a, b, c) do
    do_kind(a, b, c)
  end

  defp do_kind(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  defp do_kind(a, b, c) when (a >= b + c) or (b >= a + c) or (c >= b + a) do
    {:error, "side lengths violate triangle inequality"}
  end

  defp do_kind(a, a, a) do
    {:ok, :equilateral}
  end

  defp do_kind(a, b, c) do
    kind = if Enum.uniq([a, b, c]) != [a, b, c] do
             :isosceles
           else
             :scalene
           end

    {:ok, kind}
  end
end
