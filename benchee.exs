part1 = :application.get_key(:aoc, :modules)
    |> elem(1)
    |> Enum.filter(&(&1 |> Module.split() |> Enum.at(-1) |> String.starts_with?("Day")))
    |> Enum.map(fn module -> {module |> Module.split() |> Enum.join(" "), fn -> module.run_part1() end} end)
    |> Map.new()
IO.puts("Benchmarking part 1")
Benchee.run(part1)
part2 = :application.get_key(:aoc, :modules)
    |> elem(1)
    |> Enum.filter(&(&1 |> Module.split() |> Enum.at(-1) |> String.starts_with?("Day")))
    |> Enum.map(fn module -> {module |> Module.split() |> Enum.join(" "), fn -> module.run_part2() end} end)
    |> Map.new()


IO.puts("Benchmarking part 2")
Benchee.run(part2)

# time = :application.get_key(:aoc, :modules)
# |> elem(1)
# |> Enum.filter(&(&1 |> Module.split() |> Enum.at(-1) |> String.starts_with?("Day")))
# |> Enum.map(fn module -> { module |> Module.split() |> Enum.join(" "), %{
#         part1: (:timer.tc(fn -> module.run_part1() end) |> elem(0)) / 1_000_000,
#         part2: (:timer.tc(fn -> module.run_part2() end) |> elem(0)) / 1_000_000
#         }} end)
