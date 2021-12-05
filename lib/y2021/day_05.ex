defmodule Aoc.Y2021.Day05 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/5
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.filter(fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
    |> populate_grid(data |> get_max() |> gen_grid())
    |> Map.values()
    |> Enum.count(fn i -> i > 1 end)
  end

  def solve_part2(data) do
    data
    |> populate_grid(data |> get_max() |> gen_grid())
    |> Map.values()
    |> Enum.count(&(&1 > 1))
  end

  defp populate_grid([], grid), do: grid
  defp populate_grid([[x, x, y, y] | data], grid), do: populate_grid(data, update_grid(x, y, grid))
  defp populate_grid([[x, y1, x, y2] | data], grid), do: populate_grid(data, update_grid({x, {y1, y2}}, grid))
  defp populate_grid([[x1, y, x2, y] | data], grid), do: populate_grid(data, update_grid({{x1, x2}, y}, grid))

  defp populate_grid([[x1, y1, x2, y2] | data], grid) when abs(x1 - x2) == abs(y1 - y2),
    do: populate_grid(data, populate_diagonals(x1, y1, x2, y2, grid))

  defp populate_diagonals(x, y, x, y, grid), do: bump_grid({x, y}, grid)

  defp populate_diagonals(x1, y1, x2, y2, grid),
    do: populate_diagonals(shift(x1, x2), shift(y1, y2), x2, y2, bump_grid({x1, y1}, grid))

  defp shift(x1, x2) when x1 > x2, do: x1 - 1
  defp shift(x1, _x2), do: x1 + 1

  defp update_grid(x, y, grid) when x > y, do: update_grid(x, y + 1, bump_grid({y, y}, grid))
  defp update_grid(x, y, grid) when x < y, do: update_grid(x + 1, y, bump_grid({x, x}, grid))
  defp update_grid(x, x, grid), do: bump_grid({x, x}, grid)

  defp update_grid({x, {y1, y2}}, grid) when y1 > y2, do: update_grid({x, {y1, y2 + 1}}, bump_grid({x, y2}, grid))
  defp update_grid({x, {y1, y2}}, grid) when y1 < y2, do: update_grid({x, {y1 + 1, y2}}, bump_grid({x, y1}, grid))
  defp update_grid({x, {y, y}}, grid), do: bump_grid({x, y}, grid)

  defp update_grid({{x1, x2}, y}, grid) when x1 > x2, do: update_grid({{x1, x2 + 1}, y}, bump_grid({x2, y}, grid))
  defp update_grid({{x1, x2}, y}, grid) when x1 < x2, do: update_grid({{x1 + 1, x2}, y}, bump_grid({x1, y}, grid))
  defp update_grid({{x, x}, y}, grid), do: bump_grid({x, y}, grid)

  defp bump_grid({x, y}, grid), do: Map.update(grid, {x, y}, 0, &(&1 + 1))

  defp gen_grid({x, y}), do: Map.new(for i <- 0..x, j <- 0..y, do: {{i, j}, 0})

  defp get_max(data),
    do:
      transpose(data)
      |> then(fn [x1, y1, x2, y2] -> {Enum.max(List.flatten([x1, x2])), Enum.max(List.flatten([y1, y2]))} end)

  defp get_input() do
    get_string_input("2021", "05")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " -> ", trim: true))
    |> Enum.map(&Enum.map(&1, fn item -> String.split(item, ",", trim: true) end))
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(4, 4, :discard)
  end

  def solved_status(), do: :solved
end
