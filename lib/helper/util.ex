defmodule Aoc.Helper.Util do
  @moduledoc false

  def transpose(matrix), do: matrix |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end
