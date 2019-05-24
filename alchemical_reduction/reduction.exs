defmodule DataLoader do
  def load(file) do
    case File.read(file) do
      {:ok, data} -> {:ok, String.codepoints(String.trim(data))}
      {:error, err} -> {:error, err}
    end
  end
end

defmodule Reaction do

  def process(data), do: reaction(data, %{processed: 0, total: length(data)})

  defp type(component), do: String.upcase(component)

  defp react?(c1, c2), do: type(c1) == type(c2) and polarity(c1) != polarity(c2)

  defp polarity(component) do
    cond do
      String.upcase(component) == component -> :upcase
      String.downcase(component) == component -> :downcase
    end
  end

  defp reaction(data, analized, processed \\ [], reprocess? \\ false)

  defp reaction(data, analized, processed, reprocess?) when length(data) < 2 do
    if reprocess? do
      units_processed = analized.processed + 1
      print_percent(units_processed, analized.total)
      reaction(Enum.reverse(data ++ processed), %{processed: 0, total: length(data ++ processed)})
    else
      units_processed = analized.processed + 1
      print_percent(units_processed, analized.total)
      Enum.reverse(data ++ processed)
    end
  end

  defp reaction([c1, c2 | rest], analized, processed, reprocess?) do
    if react?(c1, c2) do
      units_processed = analized.processed + 2
      IO.puts "Reaction #{c1} and #{c2}"
      print_percent(units_processed, analized.total)
      reaction(
        rest,
        %{
          processed: units_processed,
          total: analized.total
        },
        processed, true
      )
    else
      units_processed = analized.processed + 1
      print_percent(units_processed, analized.total)
      reaction([c2 | rest], %{processed: units_processed, total: analized.total}, [c1 | processed], reprocess?)
    end
  end

  defp print_percent(processed, total) do
    IO.puts "Processed #{processed}/#{total} -> #{div (processed * 100), total }%"
  end

end

{:ok, data} = DataLoader.load("data")


IO.inspect Reaction.process(data)
