defmodule Aoc.Y2022.Day08 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/8
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def solve_part1(data) do
    Enum.reduce(1..4, [data, init_state(data)], fn _i, [data, states] ->
      set_visibility(data, states) |> Enum.map(&rotate90/1)
    end)
    |> Enum.at(1)
    |> List.flatten()
    |> Enum.count(& &1)
  end

  def solve_part2(data) do
    Enum.reduce(1..4, [data, init_state(data, true)], fn _i, [data, scores] ->
      set_score(data, scores) |> Enum.map(&rotate90/1)
    end)
    |> Enum.at(1)
    |> List.flatten()
    |> Enum.max()
  end

  def set_visibility(data, states) do
    [data, Enum.zip_with(data, states, &checker/2)]
  end

  def set_score(data, states), do: [data, Enum.zip_with(data, states, &calc_score/2)]

  def init_state(data, part2 \\ false),
    do:
      for(
        i <- 0..(length(data) - 1),
        do:
          for(
            j <- 0..(length(Enum.at(data, 0)) - 1),
            do:
              if(not part2,
                do:
                  if(i == 0 or i == length(data) - 1 or j == 0 or j == length(Enum.at(data, 0)) - 1,
                    do: true,
                    else: false
                  ),
                else: 1
              )
          )
      )

  def checker(trees, states) do
    checker(
      trees,
      states,
      Enum.reduce(trees, {0, []}, fn
        tree, {v, l} -> if v > tree, do: {v, [v | l]}, else: {tree, [v | l]}
      end)
      |> elem(1)
      |> Enum.reverse(),
      []
    )
  end

  def checker([], [], _, new_states), do: Enum.reverse(new_states)

  def checker([_tree | trees], [true | states], [_max | max_heights], new_states),
    do: checker(trees, states, max_heights, [true | new_states])

  def checker([tree | trees], [false | states], [max | max_heights], new_states) when max < tree,
    do: checker(trees, states, max_heights, [true | new_states])

  def checker([_tree | trees], [false | states], [_max | max_heights], new_states),
    do: checker(trees, states, max_heights, [false | new_states])

  def calc_score(trees, scores) do
    calc_score(trees, scores, [])
  end

  def calc_score([], [], new_scores), do: Enum.reverse(new_scores)

  def calc_score([tree | trees], [score | scores], new_scores) do
    calc_score(trees, scores, [score * get_score(trees, tree) | new_scores])
  end

  def get_score(trees, tree),
    do:
      Enum.with_index(trees, fn t, i -> {i + 1, t} end)
      |> Enum.map(fn {i, t} -> {i, t < tree} end)
      |> Enum.reject(fn {_i, t} -> t end)
      |> Enum.at(0, {length(trees)})
      |> elem(0)

  def get_input() do
    get_string_input("2022", "08")
    |> String.graphemes()
    |> Enum.reject(&(&1 == "\n"))
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(99)
  end

  def solved_status(), do: :solved
end
