paint_letter = fn coord_string ->
  coords =
    coord_string
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      String.split(x, ",", trim: true)
      |> Enum.map(fn y ->
        {i, _} = Integer.parse(y)
        i
      end)
    end)

  xs = coords |> Enum.map(&Enum.at(&1, 0))
  ys = coords |> Enum.map(&Enum.at(&1, 1))

  max_x = Enum.max(xs)
  max_y = Enum.max(ys)

  (max_y)..0
  |> Enum.map(fn y ->
    0..(max_x)
    |> Enum.map(fn x ->
      if Enum.member?(coords, [x, y]) do
        "x"
      else
        " "
      end
    end)
    |> Enum.join("")
  end)
  |> Enum.join("\n")
end

data =
  File.read!("turer.txt")
  |> String.split("---", trim: true)
  |> Enum.map(&paint_letter.(&1))
  |> Enum.join("\n\n\n")

File.write("out.txt", data)
