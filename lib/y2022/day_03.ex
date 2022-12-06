defmodule Aoc.Y2022.Day03 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/3
  """
  import Aoc.Helper.IO

  def solve_part1(data) do
    data
    |> Enum.map(fn str -> String.split_at(str, div(String.length(str), 2)) end)
    |> Enum.map(fn {str1, str2} ->
      {str1 |> String.to_charlist() |> MapSet.new(), str2 |> String.to_charlist() |> MapSet.new()}
    end)
    |> Enum.map(fn {map1, map2} -> MapSet.intersection(map1, map2) |> MapSet.to_list() end)
    |> Enum.map(&process/1)
    |> Enum.sum()
  end

  def solve_part2(data) do
    data
    |> Enum.chunk_every(3)
    |> Enum.map(fn [str1, str2, str3] ->
      {str1 |> String.to_charlist() |> MapSet.new(), str2 |> String.to_charlist() |> MapSet.new(),
       str3 |> String.to_charlist() |> MapSet.new()}
    end)
    |> Enum.map(fn {map1, map2, map3} ->
      MapSet.intersection(map1, map2) |> MapSet.intersection(map3) |> MapSet.to_list()
    end)
    |> Enum.map(&process/1)
    |> Enum.sum()
  end

  defp process([char]) when char > ?Z, do: rem(char, ?a) + 1
  defp process([char]), do: rem(char, ?A) + 27

  def get_input() do
    get_string_input("2022", "03")
    |> String.split("\n", trim: true)
  end

  def solved_status(), do: :solved
end
