defmodule Aoc.Y2022.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/7
  """
  import Aoc.Helper.IO
  @total_space 70_000_000
  @space_required 30_000_000
  @min_dir_size 100_000

  def solve_part1(data),
    do: data |> parse() |> Map.values() |> Enum.filter(fn value -> value <= @min_dir_size end) |> Enum.sum()

  def solve_part2(data),
    do:
      data
      |> parse()
      |> Map.to_list()
      |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 >= v2 end)
      |> then(fn data -> find_dir(tl(data) |> Enum.reverse(), hd(data), @total_space, @space_required) end)

  def find_dir([{_cur, cur_size} | _data], {_dir, size}, total_space, space_required)
      when total_space - size + cur_size >= space_required,
      do: cur_size

  def find_dir([_ | data], root, total_space, space_required), do: find_dir(data, root, total_space, space_required)

  def parse(data), do: parse(data, %{}, [])
  def parse([], dirs, _current_dir), do: dirs
  def parse(["$ cd .." | rest], dirs, [_ | current_dir]), do: parse(rest, dirs, current_dir)
  def parse(["$ cd " <> dir | rest], dirs, current_dir), do: parse(rest, dirs, [dir | current_dir])
  def parse(["dir " <> _dir | rest], dirs, current_dir), do: parse(rest, dirs, current_dir)
  def parse(["$ " <> _dir | rest], dirs, current_dir), do: parse(rest, dirs, current_dir)

  def parse([dir | rest], dirs, current_dir) do
    updated_dir =
      Enum.reduce(Enum.reverse(current_dir), {"/", dirs}, fn
        "/", {n, new} ->
          {n, Map.put(new, "/", Map.get(new, "/", 0) + get_size(dir))}

        curr, {n, new} ->
          {n <> "/" <> curr, Map.put(new, n <> "/" <> curr, Map.get(new, n <> "/" <> curr, 0) + get_size(dir))}
      end)
      |> elem(1)

    parse(rest, updated_dir, current_dir)
  end

  def get_size(dir), do: dir |> String.split(" ", trim: true) |> hd() |> String.to_integer()
  def get_dir(current_dir), do: Enum.reverse(current_dir) |> Enum.join("/")

  def get_input() do
    get_string_input("2022", "07")
    |> String.split("\n", trim: true)
  end

  def solved_status(), do: :solved
end
