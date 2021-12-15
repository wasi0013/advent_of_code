defmodule Aoc.Y2021.Day15 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/15
  """
  import Aoc.Helper.IO
  use Agent

  def start, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    {:ok, _} = Aoc.Y2021.Day15.start()
    result = find_path([{0, 0, 0}], data, length(data), length(Enum.at(data, 0)), 1) - Enum.at(Enum.at(data, 0), 0)
    Agent.stop(__MODULE__, :normal)
    result
  end

  def solve_part2(data) do
    {:ok, _} = Aoc.Y2021.Day15.start()
    result = find_path([{0, 0, 0}], data, length(data), length(Enum.at(data, 0)), 5) - Enum.at(Enum.at(data, 0), 0)
    Agent.stop(__MODULE__, :normal)
    result
  end

  def find_path([{_risk_level, row, column} | pqueue], data, row_size, column_size, n)
      when row < 0 or row >= row_size * n or column < 0 or column >= column_size * n do
    find_path(pqueue, data, row_size, column_size, n)
  end

  def find_path([{risk_level, row, column} | pqueue], data, row_size, column_size, n) do
    total_risk =
      Enum.at(Enum.at(data, rem(row, row_size)), rem(column, column_size)) + div(row, row_size) +
        div(column, column_size)

    total_risk =
      if total_risk > 9,
        do: risk_level + rem(total_risk, 9),
        else: risk_level + total_risk

    if Agent.get(__MODULE__, &Map.get(&1, {row, column}, nil)) > total_risk do
      Agent.update(__MODULE__, &Map.update(&1, {row, column}, total_risk, fn _ -> total_risk end))

      if row == row_size * n - 1 and column == column_size * n - 1 do
        Agent.get(__MODULE__, &Map.get(&1, {row, column}))
      else
        pqueue =
          pqueue ++
            Enum.map([[-1, 0], [0, 1], [1, 0], [0, -1]], fn [x, y] ->
              {Agent.get(__MODULE__, &Map.get(&1, {row, column})), row + x, column + y}
            end)

        find_path(Enum.sort(pqueue), data, row_size, column_size, n)
      end
    else
      find_path(pqueue, data, row_size, column_size, n)
    end
  end

  defp get_input() do
    get_string_input("2021", "15")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_charlist(&1) |> Enum.map(fn v -> v - ?0 end)))
  end

  def solved_status(), do: :solved
end
