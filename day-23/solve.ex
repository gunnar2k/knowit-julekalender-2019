is_prime? = fn n ->
  cond do
    n == 2 || n == 3 ->
      true

    true ->
      floored_sqrt =
        :math.sqrt(n)
        |> Float.floor
        |> round

      !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end

is_harshadprime? = fn n ->
  sum = Integer.digits(n) |> Enum.sum()

  Integer.mod(n, sum) == 0 && is_prime?.(sum)
end

1..98_765_432
|> Enum.filter(&is_harshadprime?.(&1))
|> Enum.count()
|> IO.puts()
