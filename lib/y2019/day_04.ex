defmodule Aoc.Y2019.Day04 do
  @moduledoc """
  Solved https://adventofcode.com/2019/day/4
  """
  def run_part1, do: get_input() |> solve_part1()
  def run_part2, do: get_input() |> solve_part2()

  def solve_part1(data) do
    Enum.sum(
      Enum.map(data, fn item ->
        if check_adjacent_digits?(item) && check_increasing?(item),
          do: 1,
          else: 0
      end)
    )
  end

  def solve_part2(data) do
    Enum.sum(
      Enum.map(data, fn item ->
        if check_adjacent_digits?(item) && check_increasing?(item) && check_larger_group?(item),
          do: 1,
          else: 0
      end)
    )
  end

  def get_input do
    # given range 236491-713787
    236_666..699_999
  end

  def check_adjacent_digits?(number) do
    Enum.any?(
      Enum.map([2, 3, 4, 5, 6, 7, 8, 9], fn n ->
        Enum.count(Integer.digits(number), &(&1 == n)) > 1
      end)
    )
  end

  def check_increasing?(number) do
    Enum.sort(Integer.digits(number)) == Integer.digits(number)
  end

  def check_larger_group?(number) do
    Enum.any?(
      Enum.map([2, 3, 4, 5, 6, 7, 8, 9], fn n ->
        Enum.count(Integer.digits(number), &(&1 == n)) == 2
      end)
    )
  end

  @spec solved_status :: atom()
  def solved_status(), do: :solved
end
