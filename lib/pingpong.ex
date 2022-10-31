defmodule Pingpong do

    def mailbox() do
      receive do
        {:ping} ->
          IO.puts " Ping !!"
          mailbox()
        {:pong} ->
          IO.puts " Pong !!"
      end
    end


    def recv do
      receive do
        {:hello, msg} -> msg
        {:world, _msg} -> "won't match"
      end


    end

end



# pid = spawn(Pingpong, :mailbox, [])
# send pid, {:ping}
# send pid, {:pong}
