defmodule SimpleQueue do
    use GenServer

    def start_link(state \\ []) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def init(state) do
        IO.puts "SimpleQueue 시작 : #{inspect self()}"
         {:ok, state}
    end

    def handle_call(:dequeue, _from, [value | state]) do
      {:reply, value, state}
    end

    def handle_call(:dequeue, _, []), do: {:reply, nil, []}

    def handle_call(:queue, from, state) do
      IO.puts "caller : #{inspect from} , state : #{inspect state}"
      {:reply, state, state}
    end

    def handle_cast({:enqueue, value}, state) do
      {:noreply, state ++ [value]}
    end

    def queue do
        IO.puts "Caller : #{inspect self()}"
       GenServer.call(__MODULE__, :queue)
    end

    def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
    def dequeue, do: GenServer.call(__MODULE__, :dequeue)
  end


#   SimpleQueue.start_link([1, 2, 3])
#   SimpleQueue.queue
#   SimpleQueue.enqueue(20)
#   SimpleQueue.dequeue


#   Process.exit( Process.whereis(SimpleQueue)     , :kill)
