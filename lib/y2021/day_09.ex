defmodule Aoc.Y2021.Day09 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/9
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> get_risk_levels() |> Enum.sum()

  def solve_part2(data) do
    data
    |> get_low_points()
    |> Enum.map(fn {i, j} -> bfs(data, i, j, MapSet.new()) end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def get_risk_levels(data),
    do: data |> get_low_points() |> Enum.map(fn {i, j} -> Enum.at(Enum.at(data, i), j) + 1 end)

  def get_low_points(data),
    do:
      for(
        i <- 0..(length(data) - 1),
        j <- 0..(length(Enum.at(data, 0)) - 1),
        lowest?(data, i, j),
        do: {i, j}
      )

  def lowest?(data, i, j), do: Enum.at(Enum.at(data, i), j) < smallest_neighbor(data, i, j)

  def smallest_neighbor(data, i, j),
    do: Enum.min(Enum.map(get_neighbors(data, i, j), fn {x, y} -> Enum.at(Enum.at(data, x), y) end))

  def get_neighbors(data, i, j) do
    for [x, y] <- [[-1, 0], [0, 1], [1, 0], [0, -1]],
        0 <= i + x and i + x < length(data) and 0 <= j + y and j + y < length(Enum.at(data, i)) do
      {i + x, j + y}
    end
  end

  def bfs(data, i, j, visited) do
    visited = MapSet.put(visited, {i, j})

    for {x, y} <- get_neighbors(data, i, j),
        Enum.at(Enum.at(data, x), y) != 9 and {x, y} not in visited,
        reduce: visited do
      visited -> MapSet.union(MapSet.put(visited, {x, y}), bfs(data, x, y, visited))
    end
  end

  defp get_input() do
    get_string_input("2021", "09")
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.graphemes() |> Enum.map(fn v -> String.to_integer(v) end)))
  end

  def solved_status(), do: :solved
end
