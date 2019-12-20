reverse = fn (n) ->
  Integer.digits(n)
  |> Enum.reverse()
  |> Integer.undigits()
end

is_palindrome = fn (n) -> reverse.(n) == n end

is_hidden_palindrome = fn (n) ->
  if is_palindrome.(n) do
    false
  else
    reverse.(n)
    |> Kernel.+(n)
    |> is_palindrome.()
  end
end

1..123454321
|> Enum.filter(&is_hidden_palindrome.(&1))
|> Enum.sum()
|> IO.puts()
