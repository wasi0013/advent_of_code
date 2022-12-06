defmodule Aoc.Y2021.Day12 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/12
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> graph() |> count(false)
  def solve_part2(data), do: data |> graph() |> count(true)

  defp graph(data),
    do:
      Enum.reduce(data, %{}, fn {from, to}, graph ->
        graph
        |> Map.update(from, [to], fn neighbors -> [to | neighbors] end)
        |> Map.update(to, [from], fn neighbors -> [from | neighbors] end)
      end)

  defp count(g, twice?), do: count(g, twice?, "start", ["start"], 0)
  defp count(_g, _twice, "end", _visited, count), do: count + 1

  defp count(g, twice?, v, visited, count), do: traverse(Map.get(g, v, []), visited, g, twice?, count)
  defp traverse([], _visited, _g, _twice, count), do: count

  defp traverse([neighbor | neighbors], visited, g, twice?, count) do
    if String.upcase(neighbor) == neighbor or neighbor not in visited do
      traverse(neighbors, visited, g, twice?, count + count(g, twice?, neighbor, [neighbor | visited], 0))
    else
      if neighbor not in ["start", "end"] and twice? do
        traverse(neighbors, visited, g, twice?, count + count(g, false, neighbor, [neighbor | visited], 0))
      else
        traverse(neighbors, visited, g, twice?, count)
      end
    end
  end

  def get_input() do
    get_string_input("2021", "12")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, "-") |> List.to_tuple()))
  end

  def solved_status(), do: :solved
end
