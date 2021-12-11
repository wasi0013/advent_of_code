defmodule Aoc.Y2021.Day11 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/11
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: grid(data) |> simulate(100, 0)
  def solve_part2(data), do: grid(data) |> find_synchronized_flash()

  defp simulate(_, 0, count), do: count

  defp simulate(grid, steps, count) do
    grid = grid |> increase_one() |> increase_adjacent([])
    simulate(set_zero(grid), steps - 1, count + count_flash(grid))
  end

  defp find_synchronized_flash(grid, steps \\ 1) do
    grid = grid |> increase_one() |> increase_adjacent([])
    if count_flash(grid) == 100, do: steps, else: find_synchronized_flash(set_zero(grid), steps + 1)
  end

  defp grid(data) do
    Map.new(
      for i <- 0..(length(data) - 1), j <- 0..(length(Enum.at(data, 0)) - 1), do: {{i, j}, Enum.at(Enum.at(data, i), j)}
    )
  end

  defp increase_one(grid) do
    for i <- 0..9, j <- 0..9, reduce: grid do
      grid -> Map.update(grid, {i, j}, nil, fn value -> value + 1 end)
    end
  end

  defp increase_adjacent(grid, visited) do
    {new_grid, visited} =
      Enum.reduce(grid, {grid, visited}, fn {{i, j}, v}, {grid, visited} ->
        if v > 9 and {i, j} not in visited do
          {update_adjacent(grid, {i, j}), [{i, j} | visited]}
        else
          {grid, visited}
        end
      end)

    if Map.equal?(new_grid, grid) do
      new_grid
    else
      increase_adjacent(new_grid, visited)
    end
  end

  defp update_adjacent(grid, {i, j}) do
    for [x, y] <- [[0, 1], [0, -1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]], reduce: grid do
      grid ->
        if i + x <= 9 and i + x >= 0 and j + y <= 9 and j + y >= 0 do
          Map.update(grid, {i + x, j + y}, nil, fn value -> value + 1 end)
        else
          grid
        end
    end
  end

  defp count_flash(grid) do
    Enum.count(Map.values(grid), fn v -> v > 9 end)
  end

  defp set_zero(grid) do
    Enum.reduce(grid, grid, fn {{i, j}, _v}, grid ->
      Map.update(grid, {i, j}, nil, fn value -> if value > 9, do: 0, else: value end)
    end)
  end

  defp get_input() do
    get_string_input("2021", "11")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&(&1 |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def solved_status(), do: :solved
end
