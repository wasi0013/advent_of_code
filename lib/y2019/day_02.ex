defmodule Aoc.Y2019.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2019/day/2
  """
  import Aoc.Helper.IO

  def run_part1 do
    get_input()
    |> set_initial_data()
    |> solve_part1()
  end

  def run_part2 do
    reset_state = get_input() |> set_initial_data()

    for noun <- 0..99, verb <- 0..99 do
      {noun, verb}
    end
    |> Enum.filter(fn {noun, verb} ->
      reset_state |> set_initial_data(noun, verb) |> solve_part1 === 19_690_720
    end)
    |> get_result()
  end

  def solve_part1(list, cursor \\ 0) when list != [] do
    case Enum.at(list, cursor) do
      1 -> list |> add(cursor + 1, cursor + 2, cursor + 3) |> solve_part1(cursor + 4)
      2 -> list |> multiply(cursor + 1, cursor + 2, cursor + 3) |> solve_part1(cursor + 4)
      99 -> hd(list)
      _ -> {:error, "Invalid OPcode"}
    end
  end

  def set_initial_data(list, op1 \\ 12, op2 \\ 2) do
    [opcode | [_ | [_ | list]]] = list
    [opcode | [op1 | [op2 | list]]]
  end

  defp add(list, op1, op2, res) do
    value = Enum.at(list, Enum.at(list, op1)) + Enum.at(list, Enum.at(list, op2))
    List.replace_at(list, Enum.at(list, res), value)
  end

  defp multiply(list, op1, op2, res) do
    value = Enum.at(list, Enum.at(list, op1)) * Enum.at(list, Enum.at(list, op2))
    List.replace_at(list, Enum.at(list, res), value)
  end

  def get_result([{noun, verb}]) do
    100 * noun + verb
  end

  def get_input() do
    get_string_input("2019", "02")
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def solved_status(), do: :solved
end
