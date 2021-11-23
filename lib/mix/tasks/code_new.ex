defmodule Mix.Tasks.CodeNew do
  use Mix.Task
  @moduledoc "The Boilerplate Generation mix task: `mix help code_new`,"
  @code_template "lib/helper/templates/code.eex"
  @test_template "lib/helper/templates/test.eex"
  @input_folder "priv/resources/"
  @usage "mix code_new -y <year> -d <day(1-25)>"

  @shortdoc "Generates boilerplate for a problem #{@usage}"
  def run(args) do
    case parse(args) do
      %{y: y, d: d} -> code_gen(y, d) |> Mix.shell().info()
      {y, d} -> code_gen(y, d) |> Mix.shell().info()
      _ -> Mix.shell().error("[Usage]: #{@usage}")
    end
  end

  defp parse(args) do
    case OptionParser.parse(args, aliases: [y: :y, d: :d], strict: [y: :integer, d: :integer]) do
      {[], opts, _} -> opts |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      {opts, [], _} -> opts |> Enum.into(%{})
      _ -> nil
    end
  end

  defp code_gen(year, day) when year >= 2015 and day in 1..25 do
    day_string = String.pad_leading(Integer.to_string(day), 2, "0")

    code_file = "lib/y#{year}/day_#{day_string}.ex"
    code_content = EEx.eval_file(@code_template, year: year, day: day)

    test_file = "test/y#{year}/day_#{day_string}_test.ex"
    test_content = EEx.eval_file(@test_template, year: year, day: day)

    input_file = "#{@input_folder}/#{year}/day#{day_string}.txt"

    create_file(code_file, code_content)
    create_file(test_file, test_content)
    create_file(input_file, "")

    "Generated 3 new files (if not already exists):\n  #{code_file}\n  #{test_file}\n  #{input_file}"
  end

  defp code_gen(_, _) do
    "Invalid Argument: [Usage] #{@usage}"
  end

  defp create_file(path, content) do
    unless File.exists?(path) do
      with :ok <- File.mkdir_p(Path.dirname(path)) do
        File.write(path, content)
      end
      File.write(path, content)
    end
  end
end
