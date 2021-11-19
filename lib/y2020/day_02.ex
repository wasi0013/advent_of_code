defmodule Aoc.Y2020.Day02 do
  @moduledoc false
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
      data
      |> Enum.map(&valid?/1)
      |> Enum.count(&(&1))
  end
  def valid?([n1, n2, letter, password]), do:
      String.to_integer(n1) <= Enum.count(String.graphemes(password), &(&1 == letter)) and String.to_integer(n2) >= Enum.count(String.graphemes(password), &(&1 == letter))

  def solve_part2(data) do
        data
        |> Enum.map(&valid2?/1)
        |> Enum.count(&(&1))
  end
  def valid2?([n1, n2, letter, password]), do:
    not (letter == Enum.at(String.graphemes(password), String.to_integer(n1) - 1) and letter == Enum.at(String.graphemes(password), String.to_integer(n2 ) - 1))
    and (letter == Enum.at(String.graphemes(password), String.to_integer(n1) - 1) or letter == Enum.at(String.graphemes(password), String.to_integer(n2 ) - 1))

  @spec get_input :: no_return
  def get_input() do
    get_string_input("2020", "02")
    |> String.split("\n")
    |> Enum.map(fn line -> Regex.run(~r/^(.*)-(.*) (.*): (.*)$/, line) |> Enum.take(-4) end)
  end
end
