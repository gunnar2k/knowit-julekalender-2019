defmodule Day13 do
  def solve do
    labyrinth =
      File.read!("./data/MAZE.TXT")
      |> Poison.decode!()

    arthur = go_to(labyrinth, {0, 0}, {499, 499}, ["syd", "aust", "vest", "nord"])
    isaac = go_to(labyrinth, {0, 0}, {499, 499}, ["aust", "syd", "vest", "nord"])

    max(arthur, isaac) - min(arthur, isaac)
  end

  defp go_to(labyrinth, current_coords, goal, priorities, visited \\ MapSet.new(), path \\ [], steps \\ 0)
  defp go_to(_, {x, y}, _, _, _, _, steps) when x == 499 and y == 499, do: steps + 1
  defp go_to(labyrinth, {x, y} = current_coords, goal, priorities, visited, path, steps) do
    current_room =
      labyrinth
      |> Enum.at(y)
      |> Enum.at(x)

    case next_unvisited_room(current_room, visited, priorities) do
      nil ->
        [prev_coords | rest] = path

        go_to(labyrinth, prev_coords, goal, priorities, MapSet.put(visited, current_coords), rest, steps)

      next_coord ->
        go_to(labyrinth, next_coord, goal, priorities, MapSet.put(visited, current_coords), [current_coords] ++ path, steps + 1)
    end
  end

  defp next_unvisited_room(%{"x" => x, "y" => y} = current_room, visited, priorities) do
    available_rooms =
      ["aust", "vest", "nord", "syd"]
      |> Enum.filter(&(!current_room[&1]))

    priorities
    |> Enum.filter(&Enum.member?(available_rooms, &1))
    |> Enum.map(fn direction ->
      case direction do
        "aust"  -> {x + 1, y}
        "vest"  -> {x - 1, y}
        "nord"  -> {x, y - 1}
        "syd"   -> {x, y + 1}
      end
    end)
    |> Enum.filter(&!MapSet.member?(visited, &1))
    |> Enum.at(0)
  end
end
