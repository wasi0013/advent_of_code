defmodule Mix.Tasks.UpdateReadme do
  @moduledoc "The Update README mix task: `mix help update_readme`"
  @readme "lib/helper/templates/README.eex"
  use Mix.Task
  @shortdoc "Generates readme with an html table representing solved aoc problems"
  def run(_) do
    {:ok, file} = File.open("README.md", [:write])
    IO.binwrite(file, EEx.eval_file(@readme, list: get_solved_list()))
  end

  def get_solved_list() do
    :application.get_key(:aoc, :modules)
    |> elem(1)
    |> Enum.filter(&(&1 |> Module.split() |> Enum.at(-1) |> String.starts_with?("Day")))
    |> Enum.map(
      &{&1.solved_status(),
       &1
       |> Module.split()
       |> Enum.take(-2)
       |> Enum.map(fn item ->
         Integer.parse(String.replace(item, ["Y", "Day"], "")) |> elem(0)
       end)}
    )
  end
end
