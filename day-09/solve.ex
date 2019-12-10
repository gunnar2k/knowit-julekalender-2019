defmodule Krampus do
  def is_krampus(n), do: is_krampus(n * n, n)
  def is_krampus(square, _) when square < 11, do: false
  def is_krampus([a, b], _) when a == 0 or b == 0, do: false
  def is_krampus([a, b], n), do: a + b == n
  def is_krampus(square, n) do
    digits = Integer.digits(square)

    1..length(digits)-1
    |> Enum.map(&[
      Enum.slice(digits, 0, &1) |> Integer.undigits,
      Enum.slice(digits, &1, length(digits)) |> Integer.undigits()
    ])
    |> Enum.map(&is_krampus(&1, n))
    |> Enum.find(& &1)
  end
end

{:ok, input} = File.read("krampus.txt")

input
|> String.split("\n", trim: true)
|> Enum.map(fn x ->
  Integer.parse(x)
  |> elem(0)
end)
|> Enum.filter(&Krampus.is_krampus/1)
|> Enum.sum()
|> IO.puts()
