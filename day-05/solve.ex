reverse_step_3 = fn word ->
  word
  |> String.split("", trim: true)
  |> Enum.chunk_every(3)
  |> Enum.reverse()
  |> Enum.join("")
end

reverse_step_2 = fn word ->
  word
  |> String.split("", trim: true)
  |> Enum.chunk_every(2)
  |> Enum.map(fn [first, last] ->
    "#{last}#{first}"
  end)
  |> Enum.join("")
end

reverse_step_1 = fn word ->
  word
  |> String.split("", trim: true)
  |> Enum.chunk_every(Kernel.trunc(String.length(word)/2))
  |> Enum.reverse()
  |> Enum.join("")
end

"tMlsioaplnKlflgiruKanliaebeLlkslikkpnerikTasatamkDpsdakeraBeIdaegptnuaKtmteorpuTaTtbtsesOHXxonibmksekaaoaKtrssegnveinRedlkkkroeekVtkekymmlooLnanoKtlstoepHrpeutdynfSneloietbol"
|> reverse_step_3.()
|> reverse_step_2.()
|> reverse_step_1.()
|> IO.puts()
