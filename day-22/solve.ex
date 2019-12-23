data =
  File.read!("forest.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.split(&1, "", trim: true))

len = length(data)-1

List.last(data)
|> Enum.with_index()
|> Enum.filter(&elem(&1, 0) == "#")
|> Enum.map(&elem(&1, 1))
|> Enum.map(fn x ->
  0..len
  |> Enum.map(fn y ->
    Enum.at(data, y)
    |> Enum.at(x)
  end)
  |> Enum.filter(& &1 == "#")
  |> Enum.join("")
  |> String.length()
end)
|> Enum.sum()
|> Kernel.*(40)
|> IO.inspect()
