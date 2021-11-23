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
      %{y: y, d: d} -> code_gen(y, d)
      {y, d} -> code_gen(y, d)
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
    Mix.shell().info([:green, "Generating new files:", :reset])
    code_file = "lib/y#{year}/day_#{day_string}.ex"
    code_content = EEx.eval_file(@code_template, year: year, day: day)

    test_file = "test/y#{year}/day_#{day_string}_test.exs"
    test_content = EEx.eval_file(@test_template, year: year, day: day)

    input_file = "#{@input_folder}/#{year}/day#{day_string}.txt"

    create_file(code_file, code_content)
    create_file(test_file, test_content)
    create_file(input_file, "")
    Mix.shell().info([:green, "Done.", :reset])
  end

  defp code_gen(_, _) do
    Mix.shell().error("Invalid Argument. [See Usage] #{@usage}")
  end

  defp create_file(path, content) do
    if File.exists?(path) do
      Mix.shell().info([:yellow, "* Skipping: ", :reset, "#{path} ", :yellow, "already exists.", :reset])
    else
      with :ok <- File.mkdir_p(Path.dirname(path)) do
        File.write(path, content)
        Mix.shell().info([:green, "* Created new file: ", :reset, "#{path}"])
      end
    end
  end
end
