defmodule Aoc.Y2021.Day17 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/17
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1([_x1, _x2, y1, _y2]), do: div(y1 * (y1 + 1), 2)
  def solve_part2(data), do: data |> count()

  defp count([x1, x2, y1, y2]),
    do:
      for(vx <- 1..x2, vy <- y1..(1 - y1), do: simulate(0, 0, vx, vy, x1, x2, y1, y2))
      |> Enum.count(&(&1 == :in))

  defp simulate(x, y, _vx, _vy, x1, x2, y1, y2) when x in x1..x2 and y in y1..y2, do: :in
  defp simulate(x, y, _vx, _vy, _x1, x2, y1, _y2) when x > x2 or y < y1, do: :out

  defp simulate(x, y, vx, vy, x1, x2, y1, y2),
    do: simulate(x + vx, y + vy, update(vx), vy - 1, x1, x2, y1, y2)

  defp update(0), do: 0
  defp update(vx), do: vx + ((vx < 0 && 1) || -1)

  defp get_input() do
    Regex.scan(~r/-*\d+/, get_string_input("2021", "17"))
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  def solved_status(), do: :solved
end
