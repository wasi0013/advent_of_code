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
    |> populate_grid(gen_grid(get_max(data)))
    |> Map.values()
    |> Enum.count(fn i -> i > 1 end)
  end

  def solve_part2(data) do
    data
    |> populate_grid(gen_grid(get_max(data)))
    |> Map.values()
    |> Enum.count(fn i -> i > 1 end)
  end

  defp populate_grid([], grid), do: grid

  defp populate_grid([[x, x, y, y] | data], grid) do
    populate_grid(data, update_grid(x, y, grid))
  end

  defp populate_grid([[x, y1, x, y2] | data], grid) do
    populate_grid(data, update_grid({x, {y1, y2}}, grid))
  end

  defp populate_grid([[x1, y, x2, y] | data], grid) do
    populate_grid(data, update_grid({{x1, x2}, y}, grid))
  end

  defp populate_grid([[x1, y1, x2, y2] | data], grid) when abs(x1 - x2) == abs(y1 - y2) do
    grid = populate_diagonals(x1, y1, x2, y2, grid)
    populate_grid(data, grid)
  end

  defp populate_diagonals(x, y, x, y, grid), do: bump_grid({x, y}, grid)

  defp populate_diagonals(x1, y1, x2, y2, grid) do
    grid = bump_grid({x1, y1}, grid)
    x1 = if x1 > x2, do: x1 - 1, else: x1 + 1
    y1 = if y1 > y2, do: y1 - 1, else: y1 + 1
    populate_diagonals(x1, y1, x2, y2, grid)
  end

  defp update_grid(x, y, grid) do
    if x > y do
      update_grid(x, y + 1, bump_grid({y, y}, grid))
    else
      if x < y do
        update_grid(x + 1, y, bump_grid({x, x}, grid))
      else
        bump_grid({x, x}, grid)
      end
    end
  end

  defp update_grid({x, {y1, y2}}, grid) do
    if y1 > y2 do
      update_grid({x, {y1, y2 + 1}}, bump_grid({x, y2}, grid))
    else
      if y1 < y2 do
        update_grid({x, {y1 + 1, y2}}, bump_grid({x, y1}, grid))
      else
        bump_grid({x, y1}, grid)
      end
    end
  end

  defp update_grid({{x1, x2}, y}, grid) do
    if x1 > x2 do
      update_grid({{x1, x2 + 1}, y}, bump_grid({x2, y}, grid))
    else
      if x1 < x2 do
        update_grid({{x1 + 1, x2}, y}, bump_grid({x1, y}, grid))
      else
        bump_grid({x1, y}, grid)
      end
    end
  end

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
