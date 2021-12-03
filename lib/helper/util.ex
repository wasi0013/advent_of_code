defmodule Aoc.Helper.Util do
  @moduledoc false

  def transpose(mat), do: transform_row(mat, [])

  def transform_row([], result), do: reverse_rows(result, [])
  def transform_row([first_row | rest], result), do: transform_row(rest, transform_column(first_row, result, []))

  def transform_column([], _, new), do: Enum.reverse(new)
  def transform_column([row_hd | rest], [], acc), do: transform_column(rest, [], [[row_hd] | acc])

  def transform_column([row_hd | row_tl], [result_hd | result_tl], acc),
    do: transform_column(row_tl, result_tl, [[row_hd | result_hd] | acc])

  def reverse_rows([], result), do: Enum.reverse(result)
  def reverse_rows([first | others], result), do: reverse_rows(others, [Enum.reverse(first) | result])
end
