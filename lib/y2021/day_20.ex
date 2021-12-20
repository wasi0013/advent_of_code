defmodule Aoc.Y2021.Day20 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/20
  """
  import Aoc.Helper.IO
  use Agent
  def start do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1({algo, img}) do
    {:ok, _} = start()
    result =
      img
      |> get_light_pixels()
      |> count(algo, 2)
    Agent.stop(__MODULE__, :normal)
    result
  end
  def solve_part2({algo, img}) do
    {:ok, _} = start()
    result =
      img
      |> get_light_pixels()
      |> count(algo, 50)
    Agent.stop(__MODULE__, :normal)
    result
  end

  def count(img, algo, n) do
    for x <- -n..(100 + n), y <- -n..(100 + n), cached_enhance(x, y, n, algo, img) == 1 do
      1
    end
    |> Enum.sum()
  end

  def print_img(img) do
    {max_x, max_y} = Enum.max(Map.keys(img))
    for y <- 0..max_y do
      for x <- 0..max_x do
        if Map.get(img, {x, y}, 0) == 1 do
          "#"
        else
          "."
        end
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
    |> IO.puts()
  end

  def cached_enhance(x, y, step, algo, img) do
    if value = Agent.get(__MODULE__, &Map.get(&1, {x, y, step})) do
      value
    else
      value = enhance(x, y, step, algo, img)
      Agent.update(__MODULE__, &Map.update(&1, {x, y, step}, value, fn _ -> value end))
      value
    end
  end
  def enhance(x, y, step, algo, img) do
    if step == 0 do
      Map.get(img, {x, y}, 0)
    else
      for y <- (y - 1)..(y + 1), x <- (x - 1)..(x + 1) do
          cached_enhance(x, y, step - 1, algo, img)
      end
      |> Integer.undigits(2)
      |> then(&Enum.at(algo, &1))
    end
  end


  defp get_input() do
    get_string_input("2021", "20")
    |> String.split("\n\n", trim: true)
    |> then(fn [algo, img] ->
      {
        String.to_charlist(algo) |> Enum.map(fn char -> Bitwise.bxor(div(char, ?.), 1) end),
        img
        |> String.split("\n", trim: true)
        |> Enum.map(&(String.to_charlist(&1) |> Enum.map(fn char -> Bitwise.bxor(div(char, ?.), 1) end)))
      }
    end)
  end

  defp get_light_pixels(img) do
    for x <- 0..(length(Enum.at(img, 0)) - 1), y <- 0..(length(img) - 1), Enum.at(Enum.at(img, y), x) == 1 do
      {{x, y}, Enum.at(Enum.at(img, y), x)}
    end
    |> Map.new()
  end

  def solved_status(), do: :solved
end