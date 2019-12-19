defmodule Day18 do
  def solve() do
    employees =
      File.read!("employees.csv")
      |> split("\n")
      |> List.delete_at(0)
      |> Enum.map(&split(&1, ","))

    names =
      File.read!("names.txt")
      |> split("---")
      |> Enum.map(&split(&1, "\n"))

    employees
    |> Enum.map(&star_wars_name(&1, names))
    |> Enum.group_by(& &1)
    |> Enum.sort_by(fn {_, list} ->
      length(list)
    end)
    |> Enum.reverse()
    |> List.first()
    |> elem(0)
  end

  def star_wars_name([first_name, last_name, gender], [males, females, surnames1, surnames2]), do:
    star_wars_first_name(first_name, males, females, gender)
    <> " " <>
    star_wars_last_name(first_name, last_name, gender, surnames1, surnames2)

  def star_wars_first_name(first_name, males, females, gender) do
    correct_list = gender_list(males, females, gender)

    index =
      first_name
      |> split("")
      |> Enum.map(&ascii/1)
      |> Enum.sum()
      |> Integer.mod(length(correct_list))

    Enum.at(correct_list, index)
  end

  def star_wars_last_name(first_name, last_name, gender, surnames1, surnames2) do
    [first_part, last_part] = split_last_name(last_name)

    index_of_first_part =
      first_part
      |> split("")
      |> Enum.map(&alphabet_position/1)
      |> Enum.sum()
      |> Integer.mod(length(surnames1))

    first_part_of_surname = Enum.at(surnames1, index_of_first_part)

    index_of_last_part =
      last_part
      |> split("")
      |> Enum.map(&ascii/1)
      |> multiply_all_numbers()
      |> Kernel.*(multiply_gender(gender, first_name, last_name))
      |> Integer.digits()
      |> Enum.sort()
      |> Enum.reverse()
      |> Integer.undigits()
      |> Integer.mod(length(surnames2))

    last_part_of_surname = Enum.at(surnames2, index_of_last_part)

    first_part_of_surname <> last_part_of_surname
  end

  def split_last_name(last_name) do
    case Integer.mod(length(split(last_name, "")), 2) do
      0 ->
        [
          String.slice(last_name, 0, trunc(String.length(last_name)/2)),
          String.slice(last_name, trunc(String.length(last_name)/2), String.length(last_name))
        ]
      1 ->
        [
          String.slice(last_name, 0, trunc(String.length(last_name)/2) + 1),
          String.slice(last_name, trunc(String.length(last_name)/2) + 1, String.length(last_name))
        ]
    end
  end

  def gender_list(_, females, "F"), do: females
  def gender_list(males, _, "M"), do: males
  defp split(str, by), do: String.split(str, by, trim: true)
  defp ascii(char), do: :binary.first(char)
  defp alphabet_position(char) do
    String.downcase(char)
    |> ascii()
    |> Integer.mod(96)
  end
  defp multiply_all_numbers([]), do: 1
  defp multiply_all_numbers([n | rest]), do: n * multiply_all_numbers(rest)
  defp multiply_gender("M", first_name, _), do: String.length(first_name)
  defp multiply_gender("F", first_name, last_name) do
    String.length(first_name) + String.length(last_name)
  end
end

Day18.solve()
|> IO.puts()
