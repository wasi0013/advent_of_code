defmodule Aoc.Y2021.Day13 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/13
  """
  import Aoc.Helper.IO
  import Enum

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1([points, ins]), do: fold(make_grid(points), at(ins, 0)) |> List.flatten() |> count(& &1)
  def solve_part2([points, ins]), do: reduce(ins, make_grid(points), fn ins, acc -> fold(acc, ins) end) |> print()

  defp make_grid(points) do
    for y <- 0..max(map(points, fn [_x, y] -> y end)) do
      for x <- 0..max(map(points, fn [x, _y] -> x end)) do
        [x, y] in points
      end
    end
  end

  def fold(grid, {:up, level}) do
    zip([grid |> take(level), grid |> take(-level) |> reverse()])
    |> map(fn {top, bottom} -> map(zip(top, bottom), fn {first, second} -> first or second end) end)
  end

  def fold(grid, {:left, level}) do
    zip([grid |> map(&take(&1, level)), grid |> map(&(take(&1, -level) |> reverse()))])
    |> map(fn {x, y} -> map(zip(x, y), fn {a, b} -> a or b end) end)
  end

  defp get_input(), do: get_string_input("2021", "13") |> parse()

  defp parse(data) do
    data
    |> String.split("\n\n", trim: true)
    |> then(fn [points, ins] -> [parse(points, :points), parse(ins, :ins)] end)
  end

  defp parse(points, :points),
    do:
      points
      |> String.split("\n", trim: true)
      |> map(fn str -> str |> String.split(",") |> map(&String.to_integer/1) end)

  defp parse(ins, :ins),
    do:
      ins
      |> String.split("\n", trim: true)
      |> map(fn str -> str |> String.split("=", trim: true) end)
      |> map(fn [direction, num] ->
        if String.contains?(direction, "x"), do: {:left, String.to_integer(num)}, else: {:up, String.to_integer(num)}
      end)

  defp print(grid),
    do: grid |> map(&map(&1, fn i -> get_char(i) end)) |> map(&join(&1, "")) |> join("\n") |> IO.puts()

  defp get_char(true), do: "⬛"
  defp get_char(false), do: "  "
  def solved_status(), do: :solved
end
