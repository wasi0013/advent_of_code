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
    scan = {Enum.filter(marked_boards, &check_winner?/1), num}
    solve_part1({rest, marked_boards}, scan)
  end

  def solve_part1({_, _}, {[board | _rest], num}),
    do: calculate_result({board, num})

  defp calculate_result({board, num}),
    do: board |> List.flatten() |> Enum.reject(&(&1 === true)) |> Enum.sum() |> then(fn total -> num * total end)

  def solve_part2({[], _marked_boards}, result, winner) do
    calculate_result(Map.get(result, hd(winner)))
  end

  def solve_part2({[num | rest], boards}, result, winner) do
    marked_boards = boards |> Enum.map(&mark_board(&1, num))
    result = update_result(marked_boards, num, marked_boards, result)
    winner = update_winner(marked_boards, marked_boards, winner)
    solve_part2({rest, marked_boards}, result, winner)
  end

  def update_winner([], _, winner), do: winner

  def update_winner([board | boards], marked_boards, winner) do
    if Enum.find_index(marked_boards, &(&1 == board)) in winner do
      update_winner(boards, marked_boards, winner)
    else
      if check_winner?(board),
        do: update_winner(boards, marked_boards, [Enum.find_index(marked_boards, &(&1 == board)) | winner]),
        else: update_winner(boards, marked_boards, winner)
    end
  end

  def update_result([], _num, _marked_boards, result), do: result

  def update_result([board | boards], num, marked_boards, result) do
    result =
      if Enum.find_index(marked_boards, &(&1 == board)) in Map.keys(result) do
        result
      else
        if check_winner?(board) do
          Map.put_new(result, Enum.find_index(marked_boards, &(&1 == board)), {board, num})
        else
          result
        end
      end

    update_result(boards, num, marked_boards, result)
  end

  def mark_board(board, num),
    do: board |> Enum.map(&Enum.map(&1, fn value -> if value == num, do: true, else: value end))

  def check_winner?(board), do: board_winning?(board) or board_winning?(transpose(board))
  defp board_winning?(board), do: board |> Enum.map(&winning_row?/1) |> winning?()
  defp winning_row?(row), do: row |> Enum.all?(&(&1 === true))
  defp winning?(row), do: row |> Enum.any?(&(&1 === true))
  defp get_input(), do: get_string_input("2021", "04") |> String.split("\n\n", trim: true) |> parse_input

  defp parse_input([inputs | boards]),
    do: {String.split(inputs, ",") |> Enum.map(&String.to_integer/1), Enum.map(boards, &parse_board/1)}

  defp parse_board(board),
    do:
      board
      |> String.split("\n", trim: true)
      |> Enum.map(fn item -> String.split(item, " ", trim: true) |> Enum.map(&String.to_integer/1) end)

  def solved_status(), do: :unsolved
end
