defmodule Aoc.Y2017.Day09 do
  @moduledoc false
  import Aoc.Helper.IO

  def run_part1, do: get_string_input("2017", "09") |> solve_part1()
  def run_part2, do: get_string_input("2017", "09") |> solve_part2()

  def solve_part1(data),
    do: data |> clean_ignored |> clean_garbage |> clean_comma |> count_score(1)

  def count_score("", _depth), do: 0
  def count_score(<<?{>> <> rest, depth), do: depth + count_score(rest, depth + 1)
  def count_score(<<?}>> <> rest, depth), do: count_score(rest, depth - 1)
  def clean_ignored(data), do: Regex.replace(~r/!./, data, "")
  def clean_garbage(data), do: Regex.replace(~r/<[^>]*>/, data, "")
  def clean_comma(data), do: Regex.replace(~r/,/, data, "")

  def solve_part2(data), do: data |> clean_ignored |> grab_garbage |> count_garbage
  def grab_garbage(data), do: Regex.scan(~r/<[^>]*>/, data)

  def count_garbage(data),
    do: Enum.map(data, fn [h | _t] -> String.length(h) - 2 end) |> Enum.sum()

end
