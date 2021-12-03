defmodule Aoc.Y2021.Day03 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/3
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def run_part1(), do: get_input() |> transpose |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: calc_consumption(data, "0") * calc_consumption(data, "1")
  def calc_consumption(data, bit), do: find_common_bits(data, bit) |> convert()

  defp find_common_bits(data, bit),
    do: data |> Enum.map(fn item -> Enum.count(item, &(&1 == bit)) >= Enum.count(item, &(&1 == flip_bit(bit))) end)

  defp flip_bit(bit), do: if(bit == "0", do: "1", else: "0")

  defp convert(data),
    do: data |> Enum.map(fn v -> if v, do: "1", else: "0" end) |> Enum.join() |> Integer.parse(2) |> elem(0)

  def solve_part2(data), do: get_rating(data, true, 0) * get_rating(data, false, 0)

  defp get_rating([x], _bool, _pos), do: x |> Enum.join() |> Integer.parse(2) |> elem(0)

  defp get_rating(bits, bool, pos) do
    bits |> Enum.filter(fn value -> Enum.at(value, pos) == pick_bits(bits, pos, bool) end) |> get_rating(bool, pos + 1)
  end

  defp get_most_common_bits(data),
    do: data |> transpose |> find_common_bits("1") |> Enum.map(fn value -> if value, do: "1", else: "0" end)

  defp pick_bits(bits, pos, true), do: bits |> get_most_common_bits() |> Enum.at(pos)
  defp pick_bits(bits, pos, false), do: bits |> get_most_common_bits() |> Enum.at(pos) |> flip_bit()

  defp get_input(), do: get_string_input("2021", "03") |> String.split("\n") |> Enum.map(&String.graphemes/1)

  def solved_status(), do: :solved
end
