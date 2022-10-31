defmodule WaitingProcess do
  @moduledoc false

  @doc false
  def loop(state) do
    receive do
      {sender, :queue} ->
              send sender,state 
              loop(state)
              
      :hi -> IO.puts "I'm here.."
            loop(state)
      :stop -> IO.puts "Bye!!"
            :ok
    end
  end

  def test_simple do
    processList =
      for _x <- 1..10_000 do
        spawn fn -> loop([1,2,3]) end
      end
      
#      send queue_pid, {self(), :queue}
      
    for p <- processList do
      send p, :hi
    end

    Process.sleep(1000)

    for p <- processList do
      send p, :stop
    end

  end

  # {t , _} = :timer.tc(ProcessTest,:test_simple, [])
end
