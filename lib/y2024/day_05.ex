defmodule Aoc.Y2024.Day05 do
  @moduledoc """
  Solved https://adventofcode.com/2024/day/5
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> process(%{}, []) |> sum_correct_order()
  def solve_part2(data), do: data |> process(%{}, []) |> sum_incorrect_order()

  def sum_correct_order([], _, result), do: result

  def sum_correct_order([a | rest], order, result) do
    if is_valid?(a, order) do
      sum_correct_order(rest, order, result + Enum.at(a, div(length(a), 2)))
    else
      sum_correct_order(rest, order, result)
    end
  end

  def sum_correct_order({list, order}), do: sum_correct_order(list, order, 0)

  def process([], order, ins), do: {ins, order}

  def process([[key, value] | data], order, ins),
    do: process(data, Map.update(order, key, [value], fn existing -> Enum.sort([value | existing]) end), ins)

  def process([a | data], order, ins), do: process(data, order, [a | ins])

  def sum_incorrect_order([], _, result), do: result

  def sum_incorrect_order([a | rest], order, result) do
    if not is_valid?(a, order) do
      sum_incorrect_order(rest, order, result + Enum.at(fix_list(a, order), div(length(a), 2)))
    else
      sum_incorrect_order(rest, order, result)
    end
  end

  def sum_incorrect_order({list, order}), do: sum_incorrect_order(list, order, 0)

  def fix_list(list, order) do
    if not is_valid?(list, order) do
      find_invalid_pair(list, order) |> swap(list) |> fix_list(order)
    else
      list
    end
  end
  def find_invalid_pair(list, order) do
    Enum.reduce_while(list, [], fn num, visited ->
      if Map.has_key?(order, num) do
        invalid_nums = Map.get(order, num, [])
        invalids = Enum.filter(invalid_nums, &(&1 in visited))

        if invalids != [] do
          {:halt, List.first(invalids) |> then(fn x -> {x, num} end)}
        else
          {:cont, [num | visited]}
        end
      else
        {:cont, [num | visited]}
      end
    end)
  end

  def is_valid?(list, order) do
    Enum.reduce_while(list, {[], true}, fn num, {visited, is_valid} ->
      if Map.has_key?(order, num) do
        restricted = Map.get(order, num, [])

        if Enum.any?(restricted, &(&1 in visited)) do
          {:halt, {visited, false}}
        else
          {:cont, {[num | visited], is_valid}}
        end
      else
        {:cont, {[num | visited], is_valid}}
      end
    end)
    |> elem(1)
  end

  def swap({a, b}, list),
    do:
      list
      |> List.update_at(Enum.find_index(list, fn x -> x == a end), fn _ -> b end)
      |> List.update_at(Enum.find_index(list, fn x -> x == b end), fn _ -> a end)

  def get_input() do
    get_string_input("2024", "05")
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      x -> String.split(x, [",", "|"], trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end

  def solved_status(), do: :solved
end
