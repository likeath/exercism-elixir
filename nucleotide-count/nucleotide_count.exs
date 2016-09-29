defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    assert_valid_strand(strand)
    assert_valid_nucleotide(nucleotide)

    Enum.count(strand, fn n -> n == nucleotide end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    assert_valid_strand(strand)

    Enum.reduce(@nucleotides, %{}, fn nucleotide, result ->
      Map.put(result, nucleotide, count(strand, nucleotide))
    end)
  end

  defp assert_valid_strand(strand) do
    Enum.each(strand, fn nucleotide -> assert_valid_nucleotide(nucleotide) end)
  end

  defp assert_valid_nucleotide(nucleotide) do
    unless Enum.member?(@nucleotides, nucleotide),
      do: raise ArgumentError
  end
end
