defmodule Day12 do
  def solve() do
    1000..9999
    |> Enum.filter(&filter_all_equal/1)
    |> Enum.map(&count_enumerations/1)
    |> Enum.filter(& &1 == 7)
    |> Enum.count()
  end

  def filter_all_equal(digits) do
    digits
    |> Integer.digits()
    |> Enum.uniq()
    |> length() != 1
  end

  def count_enumerations(_, answer \\ 0)
  def count_enumerations(d, answer) when d != 6174 do
    d = Integer.to_string(d)
    |> String.pad_leading(4, "0")
    |> String.graphemes()

    d1 = sort_asc(d)
    d2 = sort_desc(d)

    biggest = max(d1, d2)
    smallest = min(d1, d2)

    count_enumerations(biggest - smallest, answer + 1)
  end
  def count_enumerations(_, answer), do: answer

  def sort_asc(d) do
    Enum.sort(d, fn x1, x2 ->
      {d1, _} = Integer.parse(x1)
      {d2, _} = Integer.parse(x2)
      d1 <= d2
    end)
    |> to_int()
  end

  def sort_desc(d) do
    Enum.sort(d, fn x1, x2 ->
      {d1, _} = Integer.parse(x1)
      {d2, _} = Integer.parse(x2)
      d1 >= d2
    end)
    |> to_int()
  end

  def to_int(d) do
    d
    |> Enum.join("")
    |> Integer.parse()
    |> elem(0)
  end
end

Day12.solve()
|> IO.puts()
