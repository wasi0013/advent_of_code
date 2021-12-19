defmodule Aoc.Y2021.Day18 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/18
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> add |> calc_mag(3)

  def solve_part2(data, result \\ -1) do
    for a <- data, b <- data, reduce: result do
      result -> max(result, [a, b] |> add |> calc_mag(3))
    end
  end

  def add(data), do: add(hd(data), tl(data))
  def add(result, []), do: result
  def add(current, [h | rest]), do: [current, h] |> inc_depth |> reduce |> add(rest)

  def inc_depth(snails), do: snails |> Enum.concat() |> Enum.map(fn {depth, snail} -> {depth + 1, snail} end)

  def reduce(snails),
    do:
      if((new = explode(snails)) != snails,
        do: reduce(new),
        else: if((new = split(snails)) != snails, do: reduce(new), else: new)
      )

  def explode(snails), do: explode(snails, snails, 0)
  def explode([], result, _i), do: result

  def explode([{depth, value} | _snails], result, i) when depth == 4 do
    result
    |> then(fn result ->
      if i > 0 do
        {prev_level, prev_value} = Enum.at(result, i - 1)
        List.replace_at(result, i - 1, {prev_level, value + prev_value})
      else
        result
      end
    end)
    |> then(fn result ->
      if i + 2 < length(result) do
        {prev_level, prev_value} = Enum.at(result, i + 2)
        List.replace_at(result, i + 2, {prev_level, prev_value + (Enum.at(result, i + 1) |> elem(1))})
      else
        result
      end
    end)
    |> List.pop_at(i + 1)
    |> elem(1)
    |> List.replace_at(i, {3, 0})
  end

  def explode([_snail | snails], result, i), do: explode(snails, result, i + 1)

  def split(snails, prev \\ [])
  def split([], prev), do: Enum.reverse(prev)

  def split([{depth, snail} | snails], prev) when snail > 9,
    do: Enum.reverse(prev) ++ [{depth + 1, floor(snail / 2)}, {depth + 1, ceil(snail / 2)}] ++ snails

  def split([snail | snails], prev), do: split(snails, [snail | prev])

  def calc_mag([{_, value1}, {_, value2}], 0), do: value1 * 3 + value2 * 2

  def calc_mag(snails, n),
    do:
      if((new = reduce_mag(snails, n)) != snails,
        do: calc_mag(new, n),
        else: calc_mag(new, n - 1)
      )

  def reduce_mag(snails, depth), do: reduce_mag(snails, snails, depth, 0)
  def reduce_mag([], result, _depth, _i), do: result

  def reduce_mag([{depth, value} | _snails], result, depth, i) do
    value1 = Enum.at(result, i + 1) |> elem(1)

    List.replace_at(result, i, {depth - 1, value * 3 + value1 * 2})
    |> List.pop_at(i + 1)
    |> elem(1)
  end

  def reduce_mag([_ | snails], result, depth, i), do: reduce_mag(snails, result, depth, i + 1)

  def flat_list(snails, depth \\ 0, flat_list \\ [])
  def flat_list([], _depth, flat_list), do: flat_list

  def flat_list([h | snails], depth, flat_list) when is_list(h),
    do: flat_list(snails, depth, flat_list(h, depth + 1, flat_list))

  def flat_list([h | snails], depth, flat_list), do: flat_list(snails, depth, [{depth, h} | flat_list])

  defp get_input() do
    get_string_input("2021", "18")
    |> String.split("\n", trim: true)
    |> Enum.map(&Code.string_to_quoted/1)
    |> Enum.map(&(elem(&1, 1) |> flat_list() |> Enum.reverse()))
  end

  def solved_status(), do: :solved
end
