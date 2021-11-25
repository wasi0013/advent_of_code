defmodule Aoc.Y2018.Day08 do
  @moduledoc """
  Solved https://adventofcode.com/2018/day/8
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1, do: get_integer_input("2018", "08") |> solve_part1()
  @spec run_part2 :: no_return
  def run_part2, do: get_integer_input("2018", "08") |> solve_part2()

  def solve_part1([child, meta | data]), do: calculate(data, child, meta, 0)
  def calculate([], _child, _meta, sum), do: sum
  def calculate(data, 0, 0, sum), do: {data, sum}
  def calculate([hd | data], 0, meta, sum), do: calculate(data, 0, meta - 1, sum + hd)

  def calculate([child, meta | data], pchild, pmeta, sum) do
    {data, sum} = calculate(data, child, meta, sum)
    calculate(data, pchild - 1, pmeta, sum)
  end

  def solve_part2([child, meta | data]), do: value(data, child, meta, 0, %{}, child > 0)
  def value([], _child, _meta, sum, _cache, _child_flag), do: sum
  def value(data, 0, 0, sum, _cache, _child_flag), do: {data, sum}

  def value([h | data], 0, meta, sum, cache, false),
    do: value(data, 0, meta - 1, sum + h, cache, false)

  def value([h | data], 0, meta, sum, cache, true),
    do:
      value(
        data,
        0,
        meta - 1,
        sum + Map.get(cache, length(Map.values(cache)) - h + 1, 0),
        cache,
        true
      )

  def value([child, meta | data], pchild, pmeta, _sum, cache, true) do
    {data, sum} = value(data, child, meta, 0, %{}, child > 0)
    value(data, pchild - 1, pmeta, 0, Map.put(cache, pchild, sum), true)
  end

  @spec solved_status :: atom()
  def solved_status(), do: :solved
end
