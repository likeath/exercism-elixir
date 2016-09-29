defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(first_strand, second_strand) do
    count_distance(first_strand, second_strand)
  end

  defp count_distance(first_strand, second_strand) when length(first_strand) != length(second_strand) do
    {:error, "Lists must be the same length"}
  end

  defp count_distance(first_strand, second_strand) do
    {
      :ok,
      first_strand
      |> Enum.zip(second_strand)
      |> Enum.count(&different_nucleotides?/1)
    }
  end

  defp different_nucleotides?({first_nucleotide, second_nucleotide}) do
    first_nucleotide != second_nucleotide
  end
end
