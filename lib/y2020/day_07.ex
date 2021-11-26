defmodule Aoc.Y2020.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/7
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    cache = Map.new(Enum.map(data, fn {key, _bags} -> {key, nil} end))
    cache = Map.update(cache, "shiny gold", true, fn _ -> true end)
    cache = Map.update(cache, "other", false, fn _ -> false end)

    process_bags(data, cache, data)
    |> Enum.count(fn {_key, value} -> value == true end)
    |> then(fn v -> v - 1 end)
  end

  def process_bags([], cache, _reset), do: cache
  def process_bags([{"shiny gold", _bags} | rest], cache, reset), do: process_bags(rest, cache, reset)

  def process_bags([{key, bags} | rest], cache, reset) do
    cache = update_cache(key, bags, rest, cache, reset)

    if Enum.any?(cache, fn {_key, value} -> value == nil end),
      do: process_bags(reset, cache, reset),
      else: cache
  end

  def update_cache(key, bags, rest, cache, reset) do
    if cache[key] != nil do
      process_bags(rest, cache, reset)
    else
      if is_ready?(bags, cache) do
        value = check_bags?(bags, cache)
        cache = Map.update!(cache, key, fn _ -> value end)
        process_bags(rest, cache, reset)
      else
        if is_empty?(bags, cache),
          do: process_bags(rest, Map.update!(cache, key, fn _ -> false end), reset),
          else: process_bags(rest, cache, reset)
      end
    end
  end

  def check_bags?(bags, cache), do: Enum.any?(bags, fn [_n, bag] -> cache[bag] == true or bag == "shiny gold" end)
  def is_ready?(bags, cache), do: not Enum.any?(bags, fn [_n, bag] -> cache[bag] == nil and bag != "shiny gold" end)
  def is_empty?(bags, cache), do: Enum.all?(bags, fn [_n, bag] -> cache[bag] == false or bag == "other" end)

  def solve_part2(_data) do
    :unsolved
  end

  @spec get_input :: no_return
  defp get_input() do
    get_string_input("2020", "07")
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.split("contain", trim: true)))
    |> Enum.map(fn [bag | bags] -> {String.replace(bag, "bags", "") |> String.trim(), clean_bags(bags)} end)
    |> Enum.map(fn {bag, bags} -> {bag, Enum.map(bags, &split_bags(&1))} end)
    |> Enum.sort_by(fn {_, bags} -> Enum.count(bags) end)
  end

  @spec clean_bags(any) :: [binary]
  defp clean_bags(bags), do: bags |> Enum.at(0) |> String.trim(".") |> String.split(",")
  @spec split_bags(binary) :: [binary]
  defp split_bags(bags),
    do: bags |> String.replace("bags", "") |> String.replace("bag", "") |> String.trim() |> String.split(" ", parts: 2)

  @spec solved_status :: atom()
  def solved_status(), do: :part1
end
