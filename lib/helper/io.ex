defmodule Aoc.Helper.IO do
  @moduledoc false
  @spec get_string_input(String, String) :: any
  def get_string_input(year, day), do: File.read!("priv/resources/#{year}/day#{day}.txt") |>  String.trim
  def get_integer_input(year, day), do:
      get_string_input(year, day) |> String.split(" ") |> Enum.map(&String.to_integer/1)
end
