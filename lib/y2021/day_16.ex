defmodule Aoc.Y2021.Day16 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/16
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> hex_to_bin() |> parse() |> version_sum()
  def solve_part2(data), do: data |> hex_to_bin() |> parse() |> eval()

  defp parse([v1, v2, v3, 1, 0, 0 | bits]) do
    digits = extract(bits)
    extras = Enum.slice(bits, (div(length(digits), 4) * 5)..-1)

    %{
      version: Integer.undigits([v1, v2, v3], 2),
      type_id: 4,
      literal: Integer.undigits(digits, 2),
      extras: extras
    }
  end

  defp parse([v1, v2, v3, t1, t2, t3, i = 0 | bits]) do
    {bit_length, bits} = Enum.split(bits, 15)
    bit_length = bit_length |> Integer.undigits(2)
    {sub_packets, extras} = Enum.split(bits, bit_length)

    %{
      i: i,
      version: Integer.undigits([v1, v2, v3], 2),
      type_id: Integer.undigits([t1, t2, t3], 2),
      literal: false,
      sub_packets: parse_subpackets(sub_packets, []),
      extras: extras
    }
  end

  defp parse([v1, v2, v3, t1, t2, t3, i = 1 | bits]) do
    {count, bits} = Enum.split(bits, 11)
    count = count |> Integer.undigits(2)
    {result, extras} = parse_subpackets(bits, count, [])

    %{
      i: i,
      version: Integer.undigits([v1, v2, v3], 2),
      type_id: Integer.undigits([t1, t2, t3], 2),
      literal: false,
      sub_packets: result,
      extras: extras,
      count: count
    }
  end

  defp parse(_), do: %{}

  defp parse_subpackets([], result), do: result

  defp parse_subpackets(data, result) do
    value = parse(data)
    parse_subpackets(Map.get(value, :extras, []), [value | result])
  end

  defp parse_subpackets(extras, 0, result), do: {result, extras}

  defp parse_subpackets(data, count, result) do
    value = parse(data)
    parse_subpackets(Map.get(value, :extras, []), count - 1, [value | result])
  end

  defp version_sum(map) do
    if Map.get(map, :sub_packets) do
      Map.get(map, :version, 0) + Enum.sum(Enum.map(Map.get(map, :sub_packets), fn m -> version_sum(m) end))
    else
      Map.get(map, :version, 0)
    end
  end

  defp eval(map),
    do: eval(map, Map.get(map, :type_id))

  defp eval(map, 4),
    do: Map.get(map, :literal)

  defp eval(map, 0),
    do: Enum.sum(Map.get(map, :sub_packets) |> Enum.map(&eval/1))

  defp eval(map, 1),
    do: Enum.product(Map.get(map, :sub_packets) |> Enum.map(&eval/1))

  defp eval(map, 2),
    do: Enum.min(Map.get(map, :sub_packets) |> Enum.map(&eval/1))

  defp eval(map, 3),
    do: Enum.max(Map.get(map, :sub_packets) |> Enum.map(&eval/1))

  defp eval(map, 5),
    do: Map.get(map, :sub_packets) |> Enum.map(&eval/1) |> then(fn [m1, m2] -> (m1 < m2 && 1) || 0 end)

  defp eval(map, 6),
    do: Map.get(map, :sub_packets) |> Enum.map(&eval/1) |> then(fn [m1, m2] -> (m1 > m2 && 1) || 0 end)

  defp eval(map, 7),
    do: Map.get(map, :sub_packets) |> Enum.map(&eval/1) |> then(fn [m1, m2] -> (m1 == m2 && 1) || 0 end)

  defp extract(bits) do
    bits
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.reduce({}, fn
      [bit | four_bits], {} ->
        {bit, [four_bits]}

      [bit | four_bits], acc = {previous_bit, digits} ->
        if previous_bit != 0, do: {bit, [four_bits | digits]}, else: acc
    end)
    |> then(fn {_bit, digits} -> digits end)
    |> Enum.reverse()
    |> List.flatten()
  end

  defp hex_to_bin(str),
    do:
      str
      |> String.graphemes()
      |> Enum.map(&Integer.digits(&1 |> String.to_integer(16), 2))
      |> Enum.reduce([], fn digits, acc ->
        if length(digits) == 4,
          do: [digits | acc],
          else: [for(_ <- 1..(4 - length(digits)), do: 0) ++ digits | acc]
      end)
      |> Enum.reverse()
      |> List.flatten()

  defp get_input() do
    get_string_input("2021", "16")
  end

  def solved_status(), do: :solved
end
