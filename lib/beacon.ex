defmodule Beacon do
    

    def proc do
        Process.sleep 2000
        IO.puts "I'm HERE.... : #{inspect self()}"
        proc
    end


    def start do
        spawn fn -> proc() end
    end

    def start(_type, _args) do
        {:ok, start()}
    end
end