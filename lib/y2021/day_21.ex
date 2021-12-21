defmodule Aoc.Y2021.Day21 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/21
  """
  import Aoc.Helper.IO
  use Agent
  defp start, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1([_p1, num1, _p2, num2]) do
    play(num1, num2, 1, 100, 1000)
  end

  def play(num1, num2, low_dice, high_dice, winning_score) do
    Stream.cycle(low_dice..high_dice)
    |> Stream.chunk_every(6, 6)
    |> Enum.reduce_while(
      {num1 - 1, num2 - 1, 0, 0, 0},
      fn
        [a, b, c, x, y, z], {num1, num2, score1, score2, roll_count} ->
          {num1, num2} = {rem(num1 + a + b + c, 10), rem(num2 + x + y + z, 10)}
          {nscore1, nscore2} = {score1 + num1 + 1, score2 + num2 + 1}

          if nscore1 >= winning_score do
            {:halt, score2 * (roll_count + 3)}
          else
            if nscore2 >= winning_score do
              {:halt, nscore1 * (roll_count + 6)}
            else
              {:cont, {num1, num2, nscore1, nscore2, roll_count + 6}}
            end
          end
      end
    )
  end

  def solve_part2([_p1, num1, _p2, num2]) do
    {:ok, _} = start()
    result = Enum.max(cached_madness(num1 - 1, num2 - 1, 0, 0) |> Tuple.to_list())
    Agent.stop(__MODULE__, :normal)
    result
  end

  def cached_madness(num1, num2, score1, score2) do
    if value = Agent.get(__MODULE__, &Map.get(&1, {num1, num2, score1, score2})) do
      value
    else
      value = multiverse_madness(num1, num2, score1, score2)
      Agent.get_and_update(__MODULE__, &{value, Map.update(&1, {num1, num2, score1, score2}, value, fn _ -> value end)})
    end
  end

  def multiverse_madness(_num1, _num2, score1, _score2) when score1 >= 21, do: {1, 0}
  def multiverse_madness(_num1, _num2, _score1, score2) when score2 >= 21, do: {0, 1}

  def multiverse_madness(num1, num2, score1, score2) do
    scores = {0, 0}

    for a <- 1..3, b <- 1..3, c <- 1..3, reduce: scores do
      scores ->
        {pscore1, pscore2} = scores

        {nscore2, nscore1} =
          cached_madness(num2, rem(num1 + a + b + c, 10), score2, score1 + rem(num1 + a + b + c, 10) + 1)

        {pscore1 + nscore1, pscore2 + nscore2}
    end
  end

  defp get_input() do
    Regex.scan(~r/-*\d+/, get_string_input("2021", "21"))
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  def solved_status(), do: :solved
end
