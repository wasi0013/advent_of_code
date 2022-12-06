defmodule Aoc.Y2022.Day05 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/5
  """
  import Aoc.Helper.Util

  def solve_part1([config, moves]), do: simulate(parse_moves(moves), parse_config(config))
  def solve_part2([config, moves]), do: simulate(parse_moves(moves), parse_config(config), :in_order)

  def simulate([{num, src, dest} | moves], config, :in_order),
    do:
      simulate(
        moves,
        config
        |> Map.put(src, Map.get(config, src) |> Enum.drop(num))
        |> Map.put(dest, Enum.take(Map.get(config, src), num) ++ Map.get(config, dest)),
        :in_order
      )

  def simulate([], config, :in_order), do: simulate([], config)

  def simulate([{num, src, dest} | moves], config),
    do:
      simulate(
        moves,
        config
        |> Map.put(src, Map.get(config, src) |> Enum.drop(num))
        |> Map.put(
          dest,
          Map.get(config, src) |> Enum.take(num) |> Enum.reduce(Map.get(config, dest), fn elem, d -> [elem | d] end)
        )
      )

  def simulate([], config),
    do:
      Map.values(config)
      |> Enum.map(fn [first | _rest] -> first end)
      |> Enum.join()

  def parse_config(config),
    do:
      config
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> transpose()
      |> Enum.map(fn col -> Enum.reject(col, &(&1 in [" ", "[", "]"])) end)
      |> Enum.reject(&(&1 == []))
      |> Enum.zip([1, 2, 3, 4, 5, 6, 7, 8, 9])
      |> Enum.map(fn {value, key} -> {key, value} end)
      |> Enum.into(%{})

  def parse_moves(moves),
    do:
      moves
      |> String.split(["\n", " "], trim: true)
      |> Enum.chunk_every(6)
      |> Enum.map(fn ["move", num, "from", src, "to", dest] ->
        {String.to_integer(num), String.to_integer(src), String.to_integer(dest)}
      end)

  def get_input(),
    do:
      File.read!("priv/resources/2022/day05.txt")
      |> String.split("\n\n")

  def solved_status(), do: :solved
end
