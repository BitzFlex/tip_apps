defmodule Env do
    

    def checkEnv do
        name = System.get_env("NODENAME")
        IO.puts "#{name}"
        if name == nil, do: IO.puts "not defined"
    end


end