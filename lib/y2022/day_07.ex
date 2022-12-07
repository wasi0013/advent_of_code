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
      |> then(fn data -> find_smallest(tl(data) |> Enum.reverse(), hd(data), @total_space, @space_required) end)

  def find_smallest([{_cur, cur_size} | _data], {_dir, size}, total_space, space_required)
      when total_space - size + cur_size >= space_required,
      do: cur_size

  def find_smallest([_ | data], root, total_space, space_required),
    do: find_smallest(data, root, total_space, space_required)

  def parse(data), do: parse(data, %{}, [])
  def parse([], storage_data, _current_path), do: storage_data
  def parse(["$ cd .." | rest], storage_data, [_ | current_path]), do: parse(rest, storage_data, current_path)
  def parse(["$ cd " <> dir | rest], storage_data, current_path), do: parse(rest, storage_data, [dir | current_path])
  def parse(["dir " <> _dir | rest], storage_data, current_path), do: parse(rest, storage_data, current_path)
  def parse(["$ " <> _dir | rest], storage_data, current_path), do: parse(rest, storage_data, current_path)

  def parse([dir | rest], storage_data, current_path) do
    parse(rest, update_size(current_path, storage_data, dir), current_path)
  end

  def get_size(dir), do: dir |> String.split(" ", trim: true) |> hd() |> String.to_integer()

  def update_size(current_path, storage_data, dir),
    do:
      current_path
      |> Enum.reverse()
      |> Enum.reduce({"/", storage_data}, fn
        "/", {path, acc_storage} ->
          {path, Map.put(acc_storage, "/", Map.get(acc_storage, "/", 0) + get_size(dir))}

        curr, {path, acc_storage} ->
          {path <> "/" <> curr,
           Map.put(acc_storage, path <> "/" <> curr, Map.get(acc_storage, path <> "/" <> curr, 0) + get_size(dir))}
      end)
      |> elem(1)

  def get_input() do
    get_string_input("2022", "07")
    |> String.split("\n", trim: true)
  end

  def solved_status(), do: :solved
end
