defmodule WebClient  do
  require Logger


  #doc false


  def getSimple do
    HTTPoison.get("https://www.bitzflex.com",[],[recv_timeout: 8_000])
  end

  def getBody do
    HTTPoison.start
    result = HTTPoison.get! "https://www.bitzflex.com"

    %{body: body} = result
        Logger.info "#{inspect result}\nBody : #{inspect body}"
        :ok
    body
  end


  def getIsOK? do
    case HTTPoison.get("https://www.bitzflex.com",[],[recv_timeout: 100_000 , timeout: 100_000]) do
        {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect reason
      _ -> :ok
    end
  end

  def getMulti do
    for _ <- 1..1000,
      do: spawn(fn -> HTTPoison.get("https://www.bitzflex.com",[],[timeout: 60_000,  recv_timeout: 60_000]) |> IO.inspect  end)
      # do: spawn(fn -> getAndCheck()  end)
      # do: spawn(fn -> HTTPoison.get("http://localhost:5525/api/v1/time",[],[recv_timeout: 60_000]) |> IO.inspect  end)
      # do: spawn(fn -> HTTPoison.get("http://localhost:5525/api/v1/time",[],[timeout: 60_000,  recv_timeout: 60_000]) |> IO.inspect  end)
      # do: spawn(fn -> HTTPoison.get("www.bitzflex.com",[],[timeout: 60_000,  recv_timeout: 60_000]) |> IO.inspect  end)
  end

  def getMulti(url) do
    :ok = :hackney_pool.start_pool(:large_pool, [timeout: 60_000, max_connections: 10_000])
    for _ <- 1..10_000,
      do: spawn(fn -> HTTPoison.get(url,[],[recv_timeout: 8_000, hackney: [pool: :large_pool]]) |> IO.inspect  end)
      # do: spawn(fn -> HTTPoison.get("http://localhost:5525/api/v1/time",[],[recv_timeout: 60_000, hackney: [pool: :large_pool]]) |> IO.inspect  end)
  end

end
