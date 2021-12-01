defmodule Aoc.Y2020.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/2
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()

  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> Enum.map(&valid?/1) |> Enum.count(& &1)

  def valid?([n1, n2, char, password]),
    do:
      String.to_integer(n1) <= Enum.count(String.graphemes(password), &(&1 == char)) and
        String.to_integer(n2) >= Enum.count(String.graphemes(password), &(&1 == char))

  def solve_part2(data) do
    data
    |> Enum.map(&valid2?/1)
    |> Enum.count(& &1)
  end

  defp valid2?([n1, n2, char, password]),
    do:
      not (char == getchar(password, n1) and char == getchar(password, n2)) and
        (char == getchar(password, n1) or char == getchar(password, n2))

  defp getchar(password, num), do: Enum.at(String.graphemes(password), String.to_integer(num) - 1)

  defp get_input() do
    get_string_input("2020", "02")
    |> String.split("\n")
    |> Enum.map(fn line -> Regex.run(~r/^(.*)-(.*) (.*): (.*)$/, line) |> Enum.take(-4) end)
  end

  def solved_status(), do: :solved
end
