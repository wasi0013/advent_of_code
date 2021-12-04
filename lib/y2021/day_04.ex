defmodule Aoc.Y2021.Day04 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/4
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def run_part1(), do: get_input() |> solve_part1({[], 0})
  def run_part2(), do: get_input() |> solve_part2(%{}, [])

  def solve_part1({[num | rest], boards}, {[], _num}) do
    marked_boards = boards |> Enum.map(&mark_board(&1, num))
    winner = {Enum.filter(marked_boards, &check_winner?/1), num}
    solve_part1({rest, marked_boards}, winner)
  end

  def solve_part1({_, _}, {[board | _rest], num}), do: calculate_cache({board, num})

  defp calculate_cache({board, num}),
    do: board |> List.flatten() |> Enum.reject(&(&1 === true)) |> Enum.sum() |> then(fn total -> num * total end)

  def solve_part2({[], _marked_boards}, cache, winners), do: calculate_cache(Map.get(cache, hd(winners)))

  def solve_part2({[num | rest], boards}, cache, winners) do
    marked_boards = boards |> Enum.map(&mark_board(&1, num))
    cache = update_cache(marked_boards, num, marked_boards, cache)
    winners = update_winners(marked_boards, marked_boards, winners)
    solve_part2({rest, marked_boards}, cache, winners)
  end

  defp update_winners([], _, winners), do: winners

  defp update_winners([board | boards], marked_boards, winners) do
    if Enum.find_index(marked_boards, &(&1 == board)) in winners do
      update_winners(boards, marked_boards, winners)
    else
      if check_winner?(board),
        do: update_winners(boards, marked_boards, [Enum.find_index(marked_boards, &(&1 == board)) | winners]),
        else: update_winners(boards, marked_boards, winners)
    end
  end

  defp update_cache([], _num, _marked_boards, cache), do: cache

  defp update_cache([board | boards], num, marked_boards, cache),
    do: update_cache(boards, num, marked_boards, get_new_cache(num, board, marked_boards, cache))

  defp get_new_cache(num, board, marked_boards, cache) do
    if Enum.find_index(marked_boards, &(&1 == board)) in Map.keys(cache) do
      cache
    else
      if check_winner?(board),
        do: Map.put_new(cache, Enum.find_index(marked_boards, &(&1 == board)), {board, num}),
        else: cache
    end
  end

  defp mark_board(board, num),
    do: board |> Enum.map(&Enum.map(&1, fn value -> if value == num, do: true, else: value end))

  defp check_winner?(board), do: winning?(board) or winning?(transpose(board))
  defp winning?(board), do: board |> Enum.map(&winning_row?/1) |> Enum.any?(&(&1 === true))
  defp winning_row?(row), do: row |> Enum.all?(&(&1 === true))
  defp get_input(), do: get_string_input("2021", "04") |> String.split("\n\n", trim: true) |> parse_input

  defp parse_input([inputs | boards]),
    do: {String.split(inputs, ",") |> Enum.map(&String.to_integer/1), Enum.map(boards, &parse_board/1)}

  defp parse_board(board),
    do:
      board
      |> String.split("\n", trim: true)
      |> Enum.map(fn item -> String.split(item, " ", trim: true) |> Enum.map(&String.to_integer/1) end)

  def solved_status(), do: :solved
end
