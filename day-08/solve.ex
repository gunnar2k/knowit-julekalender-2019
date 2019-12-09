defmodule Game do
  require Integer

  def play(coins, wheels) do
    index = last_digit(coins)
    action = Enum.at(wheels, index) |> Enum.at(0)

    case execute(action, coins, wheels) do
      {coins, wheels} ->
        play(coins, rotate(wheels, index))

      reward ->
        reward
    end
  end

  defp first_digit(int), do: Integer.digits(int) |> List.first()
  defp last_digit(int), do: Integer.digits(int) |> List.last()

  defp execute(PLUSS4, coins, wheels), do: {coins + 4, wheels}
  defp execute(PLUSS101, coins, wheels), do: {coins + 101, wheels}
  defp execute(MINUS9, coins, wheels), do: {coins - 9, wheels}
  defp execute(MINUS1, coins, wheels), do: {coins - 1, wheels}
  defp execute(REVERSERSIFFER, coins, wheels) when coins < 0 do
    {coins, _} = execute(REVERSERSIFFER, -coins, wheels)
    {-coins, wheels}
  end
  defp execute(REVERSERSIFFER, coins, wheels) do
    coins =
      Integer.digits(coins)
      |> Enum.reverse()
      |> Integer.undigits()
    {coins, wheels}
  end
  defp execute(GANGEMSD, coins, wheels), do: {coins * first_digit(coins), wheels}
  defp execute(DELEMSD, coins, wheels) do
    d = first_digit(coins)
    {div(coins, d), wheels}
  end
  defp execute(ROTERODDE, coins, wheels) do
    wheels =
      wheels
      |> rotate(1)
      |> rotate(3)
      |> rotate(5)
      |> rotate(7)
      |> rotate(9)
    {coins, wheels}
  end
  defp execute(ROTERPAR, coins, wheels) do
    wheels =
      wheels
      |> rotate(0)
      |> rotate(2)
      |> rotate(4)
      |> rotate(6)
      |> rotate(8)
    {coins, wheels}
  end
  defp execute(ROTERALLE, coins, wheels) do
    {coins, wheels} = execute(ROTERPAR, coins, wheels)
    execute(ROTERODDE, coins, wheels)
  end
  defp execute(TREKK1FRAODDE, coins, wheels) when coins < 0 do
    {coins, _} = execute(TREKK1FRAODDE, -coins, wheels)
    {-coins, wheels}
  end
  defp execute(TREKK1FRAODDE, coins, wheels) do
    coins =
      Integer.digits(coins)
      |> Enum.map(fn d ->
        if Integer.is_odd(d) do
          d - 1
        else
          d
        end
      end)
      |> Integer.undigits()

    {coins, wheels}
  end
  defp execute(PLUSS1TILPAR, coins, wheels) when coins < 0 do
    {coins, _} = execute(PLUSS1TILPAR, -coins, wheels)
    {-coins, wheels}
  end
  defp execute(PLUSS1TILPAR, coins, wheels) do
    coins =
      Integer.digits(coins)
      |> Enum.map(fn d ->
        if Integer.is_even(d) do
          d + 1
        else
          d
        end
      end)
      |> Integer.undigits()

    {coins, wheels}
  end
  defp execute(OPP7, coins, wheels) do
    case last_digit(coins) do
      7 ->
        {coins, wheels}

      _ ->
        execute(OPP7, coins + 1, wheels)
    end
  end
  defp execute(STOPP, coins, _), do: coins

  defp rotate(wheels, index) do
    wheel = Enum.at(wheels, index)
    wheel = Enum.slice(wheel, 1..-1) ++ [Enum.at(wheel, 0)]
    List.replace_at(wheels, index, wheel)
  end
end

initial_wheels = [
  [PLUSS101, OPP7, MINUS9, PLUSS101],
  [TREKK1FRAODDE, MINUS1, MINUS9, PLUSS1TILPAR],
  [PLUSS1TILPAR, PLUSS4, PLUSS101, MINUS9],
  [MINUS9, PLUSS101, TREKK1FRAODDE, MINUS1],
  [ROTERODDE, MINUS1, PLUSS4, ROTERALLE],
  [GANGEMSD, PLUSS4, MINUS9, STOPP],
  [MINUS1, PLUSS4, MINUS9, PLUSS101],
  [PLUSS1TILPAR, MINUS9, TREKK1FRAODDE, DELEMSD],
  [PLUSS101, REVERSERSIFFER, MINUS1, ROTERPAR],
  [PLUSS4, GANGEMSD, REVERSERSIFFER, MINUS9]
]

Game.play(1, initial_wheels) |> IO.puts()
Game.play(2, initial_wheels) |> IO.puts()
Game.play(3, initial_wheels) |> IO.puts()
Game.play(4, initial_wheels) |> IO.puts()
Game.play(5, initial_wheels) |> IO.puts()
Game.play(6, initial_wheels) |> IO.puts()
Game.play(7, initial_wheels) |> IO.puts()
Game.play(8, initial_wheels) |> IO.puts()
Game.play(9, initial_wheels) |> IO.puts()
Game.play(10, initial_wheels) |> IO.puts()
