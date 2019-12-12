defmodule Day11 do
  def solve(_, speed, kms, _) when speed <= 0, do: kms - 1
  def solve(["G" | rest], speed, kms, _), do: solve(rest, speed - 27, kms + 1, 0)
  def solve(["I" | rest], speed, kms, acc), do: solve(rest, speed + 12 + acc, kms + 1, acc + 12)
  def solve(["A" | rest], speed, kms, _), do: solve(rest, speed - 59, kms + 1, 0)
  def solve(["S" | rest], speed, kms, _), do: solve(rest, speed - 212, kms + 1, 0)
  def solve(["F", "F" | _], speed, kms, _) when speed - 70 <= 0, do: kms
  def solve(["F", "F" | rest], speed, kms, _), do: solve(rest, speed - 70 + 35, kms + 2, 0)
end

File.read!("terreng.txt")
|> String.split("", trim: true)
|> Day11.solve(10703437, 1, 0)
|> IO.puts()
