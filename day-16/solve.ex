defmodule Day16 do
  def solve(fjord, position \\ %{y: 44, x: 1}, direction \\ :ne, answer \\ 1)
  def solve(_, %{x: x}, _, answer) when x == 3001, do: answer
  def solve(fjord, %{y: y, x: x} = position, direction, answer) do
    if distance_from_land(fjord, position, direction) <= 2 do
      solve(fjord, %{y: y, x: x + 1}, switch_direction(direction), answer + 1)
    else
      solve(fjord, keep_sailing(position, direction), direction, answer)
    end
  end

  def distance_from_land(fjord, %{y: y, x: x}, direction) do
    row =
      fjord
      |> Enum.map(&Enum.at(&1, x))
      |> Enum.join("")

    if direction == :ne do
      String.slice(row, 0, y)
      |> String.replace("#", "")
      |> String.length()
    else
      String.slice(row, y+1, 68)
      |> String.replace("#", "")
      |> String.length()
    end
  end

  def keep_sailing(%{y: y, x: x}, direction) when direction == :ne, do: %{y: y - 1, x: x + 1}
  def keep_sailing(%{y: y, x: x}, direction) when direction == :se, do: %{y: y + 1, x: x + 1}

  def switch_direction(direction) when direction == :ne, do: :se
  def switch_direction(direction) when direction == :se, do: :ne
end

File.read!("fjord.txt")
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, "", trim: true))
|> Day16.solve()
|> IO.puts()
