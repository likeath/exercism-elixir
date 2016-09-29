defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(first, second) do
    cond do
      first === second -> :equal
      shorter_than?(first, second) && sublist_of?(first, second) -> :sublist
      shorter_than?(second, first) && sublist_of?(second, first) -> :superlist
      :else -> :unequal
    end
  end

  defp shorter_than?(first, second) do
    length(first) < length(second)
  end

  defp sublist_of?(_, []), do: :false
  defp sublist_of?(shorter_list, longer_list) do
    cond do
      !comparable?(shorter_list, longer_list) -> false
      shorter_list === Enum.take(longer_list, length(shorter_list)) -> true
      :else -> sublist_of?(shorter_list, tl(longer_list))
    end
  end

  defp comparable?(shorter_list, longer_list) do
    Enum.min(shorter_list) >= Enum.min(longer_list)
      && Enum.max(shorter_list) <= Enum.max(longer_list)
  end
end
