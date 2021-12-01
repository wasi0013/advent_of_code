defmodule Aoc.Helper.IO do
  @moduledoc false
  @spec get_string_input(String, String) :: binary
  def get_string_input(year, day),
    do: File.read!("priv/resources/#{year}/day#{day}.txt") |> String.trim()

  def get_integer_input(year, day, sep \\ " "),
    do: get_string_input(year, day) |> String.split(sep) |> Enum.map(&String.to_integer/1)
end
