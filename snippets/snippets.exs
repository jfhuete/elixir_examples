defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, {:ok, Map.get(map, key)}
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end

  end

end

{:ok, kv} = KV.start_link
send kv, {:put, "hello", "world"}
send kv, {:get, "hello", self()}
receive do
  {:ok, value} ->
    IO.inspect value
end

