defmodule Aoc.Y2022.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/2
  """
  import Aoc.Helper.IO
  @rock 1
  @paper 2
  @scissor 3
  @lose 1
  @draw 2
  @win 3

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> parse()
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  def solve_part2(data) do
    data
    |> parse()
    |> Enum.map(&decrypt_strategy/1)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  defp get_input() do
    get_string_input("2022", "02")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  defp parse(data), do: data |> Enum.map(fn [op, _, plyr_move] -> [op - ?A + 1, plyr_move - ?X + 1] end)
  defp calculate_score([op, plyr_move]) when op == @rock and plyr_move == @scissor, do: plyr_move
  defp calculate_score([op, plyr_move]) when op == @paper and plyr_move == @rock, do: plyr_move
  defp calculate_score([op, plyr_move]) when op == @scissor and plyr_move == @paper, do: plyr_move
  defp calculate_score([op, plyr_move]) when op == plyr_move, do: 3 + plyr_move
  defp calculate_score([_op_move, plyr_move]), do: 6 + plyr_move

  defp decrypt_strategy([@rock, @lose]), do: [@rock, @scissor]
  defp decrypt_strategy([@paper, @lose]), do: [@paper, @rock]
  defp decrypt_strategy([@scissor, @lose]), do: [@scissor, @paper]
  defp decrypt_strategy([ditto, @draw]), do: [ditto, ditto]
  defp decrypt_strategy([@rock, @win]), do: [@rock, @paper]
  defp decrypt_strategy([@paper, @win]), do: [@paper, @scissor]
  defp decrypt_strategy([@scissor, @win]), do: [@scissor, @rock]
  def solved_status(), do: :solved
end
