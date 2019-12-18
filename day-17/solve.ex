defmodule Day17 do
  def solve do
    generate_triangular_numbers()
    |> Enum.filter(&is_square_or_can_be_rotated_to_square/1)
    |> Enum.count()
  end

  def is_square_or_can_be_rotated_to_square(n) do
    if is_square(n) do
      true
    else
      digits = Integer.digits(n)
      count = length(digits)

      can_be_rotated_to_square(digits, 1, count)
    end
  end

  def can_be_rotated_to_square(_, i, max) when i > max, do: false
  def can_be_rotated_to_square(digits, i, max) do
    n =
      Enum.slice(digits, i, max) ++ Enum.slice(digits, 0, i)
      |> Integer.undigits()

    if is_square(n) do
      true
    else
      can_be_rotated_to_square(digits, i + 1, max)
    end
  end

  def is_square(n) do
    sqrt = :math.sqrt(n)
    Kernel.trunc(sqrt) == sqrt
  end

  def generate_triangular_numbers(n \\ 0, acc \\ [])
  def generate_triangular_numbers(n, acc) when n == 1_000_000, do: acc
  def generate_triangular_numbers(n, acc), do:
    generate_triangular_numbers(n + 1, [triangular_number(n) | acc])
  def triangular_number(n), do: Kernel.trunc(n * (n + 1) / 2)
end

Day17.solve()
|> IO.puts()
