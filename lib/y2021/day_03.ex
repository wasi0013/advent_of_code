defmodule Aoc.Y2021.Day03 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/3
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def run_part1(), do: get_input() |> transpose |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: get_rate(data, "0") * get_rate(data, "1")
  def get_rate(data, bit), do: get_bits(data, bit) |> convert()

  defp get_bits(data, bit),
    do: data |> Enum.map(fn item -> Enum.count(item, &(&1 == bit)) >= Enum.count(item, &(&1 == next_bit(bit))) end)

  defp next_bit(bit), do: if(bit == "0", do: "1", else: "0")

  defp convert(data) do
    data
    |> Enum.map(fn value -> if value, do: "1", else: "0" end)
    |> Enum.join()
    |> Integer.parse(2)
    |> elem(0)
  end

  def solve_part2(data), do: filter_data(data, true, 0) * filter_data(data, false, 0)

  defp filter_data([x], _bool, _pos), do: x |> Enum.join() |> Integer.parse(2) |> elem(0)

  defp filter_data(data, bool, pos) do
    g = get_most_common_bits(data)
    v = if bool, do: Enum.at(g, pos), else: next_bit(Enum.at(g, pos))
    new_data = Enum.filter(data, fn value -> Enum.at(value, pos) == v end)
    filter_data(new_data, bool, pos + 1)
  end

  defp get_most_common_bits(data),
    do: data |> transpose |> get_bits("1") |> Enum.map(fn value -> if value, do: "1", else: "0" end)

  defp get_input(), do: get_string_input("2021", "03") |> String.split("\n") |> Enum.map(&String.graphemes/1)

  def solved_status(), do: :solved
end
