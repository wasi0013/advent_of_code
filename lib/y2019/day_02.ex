defmodule Aoc.Y2019.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2019/day/2
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1 do
    get_input()
    |> set_initial_data()
    |> solve_part1()
  end

  @spec run_part2 :: no_return
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

  @spec solve_part1(list, integer) :: integer
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

  @spec add(list, integer, integer, integer) :: list
  defp add(list, op1, op2, res) do
    value = Enum.at(list, Enum.at(list, op1)) + Enum.at(list, Enum.at(list, op2))
    List.replace_at(list, Enum.at(list, res), value)
  end

  @spec multiply(list, integer, integer, integer) :: list
  defp multiply(list, op1, op2, res) do
    value = Enum.at(list, Enum.at(list, op1)) * Enum.at(list, Enum.at(list, op2))
    List.replace_at(list, Enum.at(list, res), value)
  end

  def get_result([{noun, verb}]) do
    100 * noun + verb
  end

  @spec get_input :: no_return
  defp get_input() do
    get_string_input("2019", "02")
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
