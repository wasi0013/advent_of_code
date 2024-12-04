defmodule Aoc.Y2024.Day04 do
  @moduledoc """
  Solved https://adventofcode.com/2024/day/4
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  @patterns [
    {[77, 83, 77, 83], [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]},
    {[83, 83, 77, 77], [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]},
    {[77, 77, 83, 83], [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]},
    {[83, 77, 83, 77], [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]}
  ]

  def solve_part1(data) do
    diag_count([data, 0])
    |> rotate_count()
    |> diag_count()
    |> rotate_count()
    |> diag_count()
    |> rotate_count()
    |> diag_count()
    |> rotate_count()
    |> then(fn [_, xmas_count] -> xmas_count end)
  end

  def solve_part2(data),
    do:
      data
      |> str_to_grid()
      |> map_coordinates()
      |> find_coordinates()
      |> Enum.count(fn [m, {x, y}] -> xmas?(m, {x, y}) end)

  def str_to_grid(str), do: str |> String.split("\n") |> Enum.map(&String.to_charlist/1)
  def grid_to_str(mat), do: mat |> Enum.map(fn f -> "#{f}" end) |> Enum.join("\n")

  def rotate_count([data, prev]),
    do: data |> str_to_grid() |> rotate90() |> grid_to_str() |> then(fn data -> [data, prev + count_xmas(data)] end)

  def count_xmas(str), do: Regex.scan(~r/XMAS/, str) |> Enum.count()

  def diag_count([grid, prev]),
    do:
      grid
      |> str_to_grid()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {row, row_idx}, acc ->
        Enum.with_index(row)
        |> Enum.reduce(acc, fn {val, col_idx}, acc ->
          diag_idx = row_idx + col_idx
          Map.update(acc, diag_idx, [val], fn existing -> [val | existing] end)
        end)
      end)
      |> Enum.map(fn {_, values} -> values end)
      |> then(fn v -> [grid, prev + count_xmas(grid_to_str(v))] end)

  def map_coordinates(grid),
    do:
      Map.new(
        for i <- 0..(length(grid) - 1),
            j <- 0..(length(Enum.at(grid, 0)) - 1),
            do: {{i, j}, Enum.at(Enum.at(grid, i), j)}
      )

  def find_coordinates(grid, target_value \\ 65),
    do:
      grid
      |> Enum.filter(fn {_, value} -> value == target_value end)
      |> Enum.map(fn {coords, _} -> [grid, coords] end)

  def xmas?(grid, {x, y}),
    do:
      @patterns
      |> Enum.any?(fn {pattern, adjustments} ->
        match_pattern?(grid, {x, y}, pattern, adjustments)
      end)

  def match_pattern?(grid, {x, y}, pattern, adjustments),
    do:
      adjustments
      |> Enum.zip(pattern)
      |> Enum.all?(fn {{dx, dy}, expected} ->
        Map.get(grid, {x + dx, y + dy}) == expected
      end)

  def get_input(), do: get_string_input("2024", "04")

  def solved_status(), do: :solved
end
