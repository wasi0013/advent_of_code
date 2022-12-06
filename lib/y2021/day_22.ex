defmodule Aoc.Y2021.Day22 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/22
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> Enum.reject(fn {_s, r} -> Enum.min(r) < -50 or Enum.max(r) > 50 end) |> count()
  def solve_part2(data), do: data |> count()

  def count(data), do: count(%{}, data)

  def count(ranges, []),
    do:
      ranges
      |> Enum.map(fn {{x0, x1, y0, y1, z0, z1}, sign} ->
        sign * (x1 - x0 + 1) * (y1 - y0 + 1) * (z1 - z0 + 1)
      end)
      |> Enum.sum()

  def count(ranges, [{sign, [x0, x1, y0, y1, z0, z1]} | rest]) do
    Enum.reduce(ranges, %{}, fn {{cx0, cx1, cy0, cy1, cz0, cz1}, c_sign}, acc ->
      if max(x0, cx0) <= min(x1, cx1) and max(y0, cy0) <= min(y1, cy1) and max(z0, cz0) <= min(z1, cz1) do
        Map.update(
          acc,
          {max(x0, cx0), min(x1, cx1), max(y0, cy0), min(y1, cy1), max(z0, cz0), min(z1, cz1)},
          -c_sign,
          fn value -> value - c_sign end
        )
      else
        acc
      end
    end)
    |> then(fn map ->
      if sign > 0,
        do: Map.update(map, {x0, x1, y0, y1, z0, z1}, sign, fn value -> value + sign end),
        else: map
    end)
    |> Enum.reduce(ranges, fn {key, value}, acc -> Map.update(acc, key, value, fn v -> v + value end) end)
    |> count(rest)
  end

  def get_input() do
    get_string_input("2021", "22")
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "on " <> row -> {1, row |> process}
      "off " <> row -> {-1, row |> process}
    end)
  end

  defp process(row), do: Regex.scan(~r/-*\d+/, row) |> List.flatten() |> Enum.map(&String.to_integer/1)
  def solved_status(), do: :solved
end
