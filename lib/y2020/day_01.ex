defmodule Aoc.Y2020.Day01 do
  @moduledoc false
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(),
    do:
      get_string_input("2020", "01")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(),
    do:
      get_string_input("2020", "01")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> solve_part2()

  def solve_part1(data) do
    [head | _tail] = for num1 <- data, num2 <- data, num1 + num2 == 2020, do: num1 * num2
    head
  end

  def solve_part2(data) do
    [head | _tail] =
      for num1 <- data,
          num2 <- data,
          num3 <- data,
          num1 + num2 + num3 == 2020,
          do: num1 * num2 * num3

    head
  end

  @spec solved_status :: atom()
  def solved_status(), do: :solved
end
