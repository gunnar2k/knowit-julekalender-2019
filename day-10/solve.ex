defmodule Day10 do
  def solve(data) do
    antall_hele_tuber_tannkrem_brukt_i_2018(data) *
    antall_hele_flasker_sjampo_brukt_i_2018(data) *
    antall_hele_toalettruller_brukt_i_2018(data) *
    antall_milliliter_sjampo_brukt_på_søndager(data) *
    antall_meter_toalettpapir_brukt_på_onsdager(data)
  end

  def parse(row) do
    day = Enum.join(row, "")
    %{
      day: parse_day(day),
      tannkrem: parse_tannkrem(day),
      sjampo: parse_sjampo(day),
      toalettpapir: parse_toalettpapir(day)
    }
  end

  def capture(regex, data, key) do
    Regex.named_captures(regex, data)
    |> Map.get(key)
    |> Integer.parse()
    |> elem(0)
  end

  def parse_toalettpapir(val), do: capture(~r/(?<toalettpapir>\d{1,2}) meter toalettpapir.*/, val, "toalettpapir")
  def parse_sjampo(val), do: capture(~r/(?<sjampo>\d{1,2}) ml sjampo.*/, val, "sjampo")
  def parse_tannkrem(val), do: capture(~r/(?<tannkrem>\d{1,2}) ml tannkrem.*/, val, "tannkrem")

  def parse_day(row) do
    months = %{
      "Jan" => 1, "Feb" => 2, "Mar" => 3,
      "Apr" => 4, "May" => 5, "Jun" => 6,
      "Jul" => 7, "Aug" => 8, "Sep" => 9,
      "Oct" => 10, "Nov" => 11, "Dec" => 12
    }
    date = Regex.named_captures(~r/(?<month>[A-Z]{1}[a-z]{1,3}) (?<day>[0-9]{1,2})\:/, row)

    {day, _} = Integer.parse(date["day"])
    Date.new(2018, months[date["month"]], day)
    |> elem(1)
    |> Date.day_of_week()
  end

  def sum_by_key(data, key) do
    data
    |> Enum.map(& &1[key])
    |> Enum.sum()
  end

  def sum_day(data, day_of_week, key) do
    data
    |> Enum.filter(& &1.day == day_of_week)
    |> Enum.map(& &1[key])
    |> Enum.sum()
  end

  def antall_hele_tuber_tannkrem_brukt_i_2018(data), do: sum_by_key(data, :tannkrem) |> div(125)
  def antall_hele_flasker_sjampo_brukt_i_2018(data), do: sum_by_key(data, :sjampo) |> div(300)
  def antall_hele_toalettruller_brukt_i_2018(data), do: sum_by_key(data, :toalettpapir) |> div(25)
  def antall_milliliter_sjampo_brukt_på_søndager(data), do: sum_day(data, 7, :sjampo)
  def antall_meter_toalettpapir_brukt_på_onsdager(data), do: sum_day(data, 3, :toalettpapir)
end

{:ok, input} = File.read("logg.txt")

data =
  input
  |> String.split("\n", trim: true)
  |> Enum.chunk_every(4)
  |> Enum.map(&Day10.parse/1)

Day10.solve(data) |> IO.puts()
