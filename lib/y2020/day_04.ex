defmodule Aoc.Y2020.Day04 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/4
  """
  import Aoc.Helper.IO
  @fields ~w[byr iyr eyr hgt hcl ecl pid]

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(fn list -> MapSet.new(Enum.map(list, fn item -> String.split(item, ":") |> Enum.at(0) end)) end)
    |> Enum.map(fn mapset -> MapSet.subset?(MapSet.new(@fields), mapset) end)
    |> Enum.count(&(&1 == true))
  end

  def solve_part2(data) do
    data
    |> Enum.map(fn list -> Enum.map(list, fn item -> String.split(item, ":") end) end)
    |> Enum.filter(fn item -> MapSet.subset?(MapSet.new(@fields), MapSet.new(item, fn [field, _value] -> field end)) end)
    |> Enum.map(fn item -> Enum.all?(item, &check_validity?/1) end)
    |> Enum.count(&(&1 == true))
  end

  defp check_validity?(["cid", _value]), do: true
  defp check_validity?(["hcl", value]), do: Regex.match?(~r/^#[a-f\d]{6}$/, value)
  defp check_validity?(["ecl", value]), do: Regex.match?(~r/^(amb|blu|brn|gry|grn|hzl|oth)$/, value)
  defp check_validity?(["pid", value]), do: Regex.match?(~r/^\d{9}$/, value)
  defp check_validity?(["byr", value]), do: Regex.match?(~r/^\d{4}$/, value) and String.to_integer(value) in 1920..2002
  defp check_validity?(["eyr", value]), do: Regex.match?(~r/^\d{4}$/, value) and String.to_integer(value) in 2020..2030
  defp check_validity?(["iyr", value]), do: Regex.match?(~r/^\d{4}$/, value) and String.to_integer(value) in 2010..2020

  defp check_validity?(["hgt", value]) do
    if Regex.match?(~r/^(\d+?)(in|cm?)$/, value) do
      case Regex.run(~r/^(\d+?)(in|cm?)$/, value) |> Enum.take(-2) do
        [num, "in"] -> String.to_integer(num) in 59..76
        [num, "cm"] -> String.to_integer(num) in 150..193
        _ -> false
      end
    end
  end

  @spec get_input() :: no_return
  defp get_input() do
    get_string_input("2020", "04")
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, [" ", "\n"]))
  end
end
