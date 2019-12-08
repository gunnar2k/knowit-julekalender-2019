defmodule FindY do
  def for_day(x, current \\ 2) do
    b = current * x
    r = Integer.mod(b, 27644437)
    if r == 1 do
      current
    else
      FindY.for_day(x, current + 1)
    end
  end
end

FindY.for_day(7)
|> Kernel.*(5897)
|> Integer.mod(27644437)
|> IO.puts()
