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
  def count(strand, nucleotide), do: count(strand, nucleotide, 0)
  def count([], nucleotide, count), do: count
  def count([head | tail], nucleotide, count) do
    if head == nucleotide, do: count(tail, nucleotide, count + 1), else: count(tail, nucleotide, count)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand), do: histogram(strand, initialize_map(@nucleotides))
  def histogram([], result), do: result
  def histogram([head | tail], result) do
    histogram(tail, Map.put(result, head, Map.get(result, head) + 1))
  end

  def initialize_map(string), do: initialize_map(string, %{})
  def initialize_map([], result), do: result
  def initialize_map([head | tail], result), do: initialize_map(tail, Map.put(result, head, 0))
end
