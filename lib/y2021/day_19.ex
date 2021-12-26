defmodule Aoc.Y2021.Day19 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/19
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(scanners), do: scanners |> count()
  def solve_part2(scanners), do: scanners |> find_largest_distance()

  defp count({[], beacons}), do: beacons |> MapSet.size()

  defp count({scanners, beacons}) do
    Enum.reduce(scanners, {scanners, beacons}, fn scanner, {rest, beacons} ->
      if (matched = find_match_point(scanner, beacons)) != [] do
        {List.delete(rest, scanner), update_beacons(matched, beacons, scanner)}
      else
        {rest, beacons}
      end
    end)
    |> count()
  end

  defp count(scanners), do: count({scanners, scanners |> hd |> MapSet.new()})

  defp find_largest_distance({[], _beacons, points}),
    do:
      Enum.flat_map(points, fn point1 -> Enum.map(points, fn point2 -> manhatten_distance(point1, point2) end) end)
      |> Enum.max()

  defp find_largest_distance({scanners, beacons, points}) do
    Enum.reduce(scanners, {scanners, beacons, points}, fn scanner, {rest, beacons, points} ->
      if (matched = find_match_point(scanner, beacons)) != [] do
        {List.delete(rest, scanner), update_beacons(matched, beacons, scanner), [matched |> hd() |> elem(0) | points]}
      else
        {rest, beacons, points}
      end
    end)
    |> find_largest_distance()
  end

  defp find_largest_distance(scanners), do: find_largest_distance({scanners, scanners |> hd |> MapSet.new(), []})

  defp update_beacons([{point, rmatrix}], beacons, scanner),
    do: Enum.map(scanner, &add(rotate(&1, rmatrix), point)) |> MapSet.new() |> MapSet.union(beacons)

  defp find_match_point(scanner, beacons) do
    Enum.flat_map(rotations(), fn rmatrix ->
      scanner
      |> Enum.map(fn point -> rotate(point, rmatrix) end)
      |> Enum.flat_map(&Enum.map(beacons, fn point -> subtract(&1, point) end))
      |> Enum.frequencies()
      |> Enum.reject(&(&1 |> elem(1) < 12))
      |> Enum.map(&{&1 |> elem(0), rmatrix})
    end)
  end

  defp get_input() do
    get_string_input("2021", "19")
    |> String.split("\n\n", trim: true)
    |> Enum.map(
      &(String.split(&1, "\n", trim: true)
        |> Enum.slice(1..-1)
        |> Enum.map(fn nums ->
          String.split(nums, ",", trim: true)
          |> Enum.map(fn num -> String.to_integer(num) end)
        end))
    )
  end

  defp add([x, y, z], [a, b, c]), do: [x + a, y + b, z + c]
  defp subtract([x, y, z], [a, b, c]), do: [a - x, b - y, c - z]
  defp manhatten_distance([a, b, c], [d, e, f]), do: abs(d - a) + abs(e - b) + abs(f - c)

  defp rotate([x, y, z], [[a, b, c], [d, e, f], [g, h, i]]),
    do: [x * a + y * b + z * c, x * d + y * e + z * f, x * g + y * h + z * i]

  defp rotations() do
    [
      [
        [-1, 0, 0],
        [0, 0, -1],
        [0, -1, 0]
      ],
      [
        [0, -1, 0],
        [-1, 0, 0],
        [0, 0, -1]
      ],
      [
        [0, 0, -1],
        [0, -1, 0],
        [-1, 0, 0]
      ],
      [
        [-1, 0, 0],
        [0, -1, 0],
        [0, 0, 1]
      ],
      [
        [0, -1, 0],
        [0, 0, 1],
        [-1, 0, 0]
      ],
      [
        [0, 0, 1],
        [-1, 0, 0],
        [0, -1, 0]
      ],
      [
        [-1, 0, 0],
        [0, 1, 0],
        [0, 0, -1]
      ],
      [
        [0, 1, 0],
        [0, 0, -1],
        [-1, 0, 0]
      ],
      [
        [0, 0, -1],
        [-1, 0, 0],
        [0, 1, 0]
      ],
      [
        [-1, 0, 0],
        [0, 0, 1],
        [0, 1, 0]
      ],
      [
        [0, 1, 0],
        [-1, 0, 0],
        [0, 0, 1]
      ],
      [
        [0, 0, 1],
        [0, 1, 0],
        [-1, 0, 0]
      ],
      [
        [1, 0, 0],
        [0, -1, 0],
        [0, 0, -1]
      ],
      [
        [0, -1, 0],
        [0, 0, -1],
        [1, 0, 0]
      ],
      [
        [0, 0, -1],
        [1, 0, 0],
        [0, -1, 0]
      ],
      [
        [1, 0, 0],
        [0, 0, 1],
        [0, -1, 0]
      ],
      [
        [0, -1, 0],
        [1, 0, 0],
        [0, 0, 1]
      ],
      [
        [0, 0, 1],
        [0, -1, 0],
        [1, 0, 0]
      ],
      [
        [1, 0, 0],
        [0, 0, -1],
        [0, 1, 0]
      ],
      [
        [0, 1, 0],
        [1, 0, 0],
        [0, 0, -1]
      ],
      [
        [0, 0, -1],
        [0, 1, 0],
        [1, 0, 0]
      ],
      [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1]
      ],
      [
        [0, 1, 0],
        [0, 0, 1],
        [1, 0, 0]
      ],
      [
        [0, 0, 1],
        [1, 0, 0],
        [0, 1, 0]
      ]
    ]
  end

  def solved_status(), do: :solved
end
