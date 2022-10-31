defmodule IdleProcess do
  @moduledoc false

  @doc false
  def loop(state) do
    loop(state)
  end


  def run_process do
    _processList =
      for _x <- 1..20_000 do
        spawn fn -> loop([]) end
      end

  end

  # {t , _} = :timer.tc(IdleProcess,:run_process, [])

end
