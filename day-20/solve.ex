defmodule Day20 do
  @max_n 1_000_740 + 1
  # @max_n 9

  def solve() do
    all_primes = PrimeArray.get_primes(@max_n)

    step()
  end

  def step(n \\ 1, elfs \\ [0, 0, 0, 0, 0], current \\ 0, direction \\ :cw, primes \\ [])
  def step(@max_n, elfs, _, _, _) do
    IO.puts("FINAL:")
    IO.inspect(elfs)
    sorted_elfs = Enum.sort(elfs)
    |> IO.inspect()

    (Enum.at(sorted_elfs, 4) - Enum.at(sorted_elfs, 0))
    |> IO.inspect()
  end
  def step(n, elfs, current, direction, primes) do
    cond do
      has_shittiest_elf?(elfs, current) && Enum.member?(primes, n) ->
        shittiest_elf = whos_the_shittiest_elf(elfs, current)
        elfs = List.update_at(elfs, shittiest_elf, &(&1 + 1))
        current = shittiest_elf
        next = continue(current, direction)
        step(n + 1, elfs, next, direction)

      Integer.mod(n, 28) == 0 ->
        direction = switch(direction)
        next = continue(current, direction)
        elfs = List.update_at(elfs, next, &(&1 + 1))
        step(n + 1, elfs, next, direction)

      Integer.mod(n, 2) == 0 && is_best_elf?(elfs, current) ->
        # IO.inspect("Alv #{current+1} gjør steg #{n} (Regel 3)")
        next = continue(current, direction)
        # next = continue(next, direction)
        # elfs = List.update_at(elfs, next, &(&1 + 1))
        # |> IO.inspect()
        # next = continue(current, direction)
        step(n + 1, elfs, next, direction)

      Integer.mod(n, 7) == 0 ->
        # IO.inspect("Alv #{current+1} gjør steg #{n} (Regel 4)")
        elfs = List.update_at(elfs, 4, &(&1 + 1))
        # |> IO.inspect()
        current = 4
        next = continue(current, direction)
        step(n + 1, elfs, next, direction)

      true ->
        # IO.inspect("Alv #{current+1} gjør steg #{n} (Regel 5)")
        elfs = List.update_at(elfs, current, &(&1 + 1))
        # |> IO.inspect()

        next = continue(current, direction)
        step(n + 1, elfs, next, direction)
    end
  end

  def has_shittiest_elf?(elfs, current) do
    min_elf = Enum.min(elfs)
    Enum.count(elfs, fn x -> x == min_elf end) == 1
  end

  def whos_the_shittiest_elf(elfs, current) do
    min_elf = Enum.min(elfs)
    elfs
    |> Enum.with_index()
    |> Enum.find(fn {val, index} ->
      val == min_elf
    end)
    |> elem(1)
  end

  def is_best_elf?(elfs, current) do
    elf = Enum.at(elfs, current)
    if elf == Enum.max(elfs) && Enum.count(elfs, fn x -> x == elf end) == 1 do
      true
    end
  end

  def switch(:cw), do: :ccw
  def switch(:ccw), do: :cw

  def continue(4, :cw), do: 0
  def continue(current, :cw), do: current + 1

  def continue(0, :ccw), do: 4
  def continue(current, :ccw), do: current - 1
end

defmodule PrimeArray do
  def get_primes(n) when n < 2, do: []
  def get_primes(n), do: Enum.filter(2..n, &is_prime?(&1))

  defp is_prime?(n) when n in [2, 3], do: true
  defp is_prime?(n) do
    floored_sqrt = :math.sqrt(n)
      |> Float.floor
      |> round
    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end



Day20.solve()
|> IO.inspect()
