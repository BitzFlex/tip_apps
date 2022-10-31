defmodule Lotto do
    @moduledoc """
    """

    @doc false
    def lotto do
        Enum.to_list(1..45)
            |> Enum.shuffle
            |> Enum.slice(0..5)
            |> Enum.sort
            |> Enum.join(",")
            |> IO.puts

        IO.puts "#{inspect self()}"

        lotto()
    end

  end
