defmodule RNATranscription do
  @dictionary %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&(rna_nucleotide/1))
  end

  defp rna_nucleotide(dna_nucleotide) do
    Map.fetch!(@dictionary, dna_nucleotide)
  end
end
