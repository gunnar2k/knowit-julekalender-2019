defmodule Day2 do
  def solve(_, solution \\ 0)
  def solve([], solution), do: solution
  def solve([row | rest], solution) do
    solve(rest, solution + calc_row(row, %{row_total: 0, current_total: 0, start: true}))
  end
  def calc_row([], %{row_total: row_total}), do: row_total
  def calc_row(["#" | rest], %{start: true} = row_state) do
    calc_row(rest, Map.put(row_state, :start, false))
  end
  def calc_row(["#" | rest], %{row_total: row_total, current_total: current_total, start: false} = row_state) do
    calc_row(rest, Map.merge(row_state, %{row_total: row_total + current_total, current_total: 0}))
  end
  def calc_row([" " | rest], %{start: true} = row_state) do
    calc_row(rest, row_state)
  end
  def calc_row([" " | rest], %{current_total: current_total, start: false} = row_state) do
    calc_row(rest, Map.put(row_state, :current_total, current_total + 1))
  end
end

{:ok, input} = File.read("world.txt")

input
|> String.split("\n")
|> Enum.map(&String.split(&1, "", trim: true))
|> Day2.solve()
|> IO.puts()
