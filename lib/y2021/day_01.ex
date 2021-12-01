defmodule Aoc.Y2021.Day01 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/1
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()

  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.reduce({hd(data), 0}, fn item, {prev, acc} -> {item, acc + ((prev < item && 1) || 0)} end)
    |> elem(1)
  end

  def solve_part2(data), do: data |> chunk_sum |> solve_part1()
  defp chunk_sum(data), do: data |> Enum.chunk_every(3, 1) |> Enum.map(&Enum.sum/1)

  defp get_input(), do: get_integer_input("2021", "01", "\n")

  def solved_status(), do: :solved
end
