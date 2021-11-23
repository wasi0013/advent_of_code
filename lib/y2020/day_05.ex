defmodule Aoc.Y2020.Day05 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/5
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> Enum.map(&get_seat_id/1) |> Enum.max()

  def solve_part2(data) do
    seats = data |> Enum.map(&get_seat_id/1) |> Enum.sort(:asc)

    MapSet.difference(MapSet.new(Enum.min(seats)..Enum.max(seats)), MapSet.new(seats))
    |> Enum.at(0)
  end

  defp get_seat_id(seat),
    do:
      binary_search(Enum.slice(seat, 0..6), Enum.to_list(0..127)) * 8 +
        binary_search(Enum.slice(seat, 7..9), Enum.to_list(0..7))

  defp binary_search([], list), do: hd(list)
  defp binary_search(["F" | rest], list), do: binary_search(rest, Enum.split(list, round(length(list) / 2)) |> elem(0))
  defp binary_search(["B" | rest], list), do: binary_search(rest, Enum.split(list, round(length(list) / 2)) |> elem(1))
  defp binary_search(["L" | rest], list), do: binary_search(rest, Enum.split(list, round(length(list) / 2)) |> elem(0))
  defp binary_search(["R" | rest], list), do: binary_search(rest, Enum.split(list, round(length(list) / 2)) |> elem(1))

  @spec get_input() :: no_return
  defp get_input(), do: get_string_input("2020", "05") |> String.split("\n") |> Enum.map(&String.graphemes/1)
end