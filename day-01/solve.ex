defmodule Day1 do
  def solve([sheep_today | rest], %{
        days: days,
        hunger: hunger,
        rage: rage,
        extra_sheep: extra_sheep
      } = _state) do
    leftovers = sheep_today + extra_sheep - hunger

    cond do
      rage == 5 ->
        days - 1

      leftovers < 0 ->
        solve(rest, %{
          days: days + 1,
          hunger: hunger - 1,
          rage: rage + 1,
          extra_sheep: 0
        })

      leftovers >= 0 ->
        solve(rest, %{
          days: days + 1,
          hunger: hunger + 1,
          rage: 0,
          extra_sheep: leftovers
        })

      true ->
        IO.puts("Unhandled case")
    end
  end
end

{:ok, raw_input} = File.read("sau.txt")

input =
  String.split(raw_input, " ")
  |> Enum.map(&Integer.parse/1)
  |> Enum.map(&elem(&1, 0))

initial_state = %{
  days: 0,
  hunger: 50,
  rage: 0,
  extra_sheep: 0
}

Day1.solve(input, initial_state)
|> IO.puts()
