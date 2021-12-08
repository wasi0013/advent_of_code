defmodule Aoc.Helper.Util do
  @moduledoc false

  def transpose(matrix), do: matrix |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  def permutations([]), do: [[]]
  def permutations(elements), do: for(elem <- elements, rest <- permutations(elements -- [elem]), do: [elem | rest])

end
