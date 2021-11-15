defmodule Aoc.Helper.IO do
  @moduledoc false
  @spec get_string_input(String, String) :: any
  def get_string_input(year, day) do
     case File.read("priv/resources/#{year}/day#{day}.txt") do
      {:ok, data} ->  String.trim(data)
      {:error, reason} -> raise reason
    end

  end
end
