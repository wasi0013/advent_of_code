defmodule Aoc.Y2021.Day25 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/25
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> make_grid() |> count(1, length(Enum.at(data, 0)), length(data))

  defp count([right_facing, down_facing], step, max_x, max_y) do
    occupied_area = MapSet.union(right_facing, down_facing)

    right_facing_new =
      Enum.reduce(right_facing, MapSet.new(), fn {x, y}, new ->
        MapSet.put(
          new,
          if(MapSet.member?(occupied_area, {rem(x + 1, max_x), y}),
            do: {x, y},
            else: {rem(x + 1, max_x), y}
          )
        )
      end)

    occupied_area = MapSet.union(right_facing_new, down_facing)

    down_facing_new =
      Enum.reduce(down_facing, MapSet.new(), fn {x, y}, new ->
        MapSet.put(
          new,
          if(MapSet.member?(occupied_area, {x, rem(y + 1, max_y)}),
            do: {x, y},
            else: {x, rem(y + 1, max_y)}
          )
        )
      end)

    if MapSet.equal?(down_facing, down_facing_new) and MapSet.equal?(right_facing, right_facing_new) do
      step
    else
      count([right_facing_new, down_facing_new], step + 1, max_x, max_y)
    end
  end

  defp make_grid(data) do

    for y <- 0..(length(data) - 1), x <- 0..(length(Enum.at(data, 0)) - 1), reduce: [[], []] do
      [right_facing, down_facing] ->
        if Enum.at(Enum.at(data, y), x) == ">" do
          [[{x, y} | right_facing], down_facing]
        else
          if Enum.at(Enum.at(data, y), x) == "v" do
            [right_facing, [{x, y} | down_facing]]
          else
            [right_facing, down_facing]
          end
        end
    end
    |> Enum.map(&MapSet.new/1)
  end

  def solve_part2(_data) do
    :unsolved
  end

  defp get_input() do
    get_string_input("2021", "25")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def solved_status(), do: :part1
end
