defmodule Factorial do
  @moduledoc false

  @doc false
  def of(0), do: 1

  def of(n) do
    n * of(n-1)
  end

  def remote_of do
    receive do
      {:factorial,value, from} ->
        IO.puts "start calculation..."
        send from, {:result, value, of(value)}
    end
  end


  def calcRemote(node, f) do
    :pong = Node.ping(node)

    r_p = Node.spawn(node,fn -> Factorial.remote_of() end)
    #r_p = Node.spawn(node, Factorial , :remote_of , [] )
    send r_p , {:factorial, f, self()}
    r_p
  end

  # iex --sname ntels -S mix
  # iex --sname ncomz -S mix

  # Node.connect(node)
  # :net_kernel.monitor_nodes(true)

  # Node.connect(:ntels@lilac)

  # Node.self
  # Node.list

  # Factorial.calcRemote(:aCom@lilac, 100)
  # Factorial.calcRemote(:ntels@lilac, 100)

end
