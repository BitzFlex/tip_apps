defmodule Queue.Supervisor do
    use Supervisor
    def start_link(opts) do
      Supervisor.start_link(__MODULE__, :ok, opts)
    end
  
    def init(:ok) do
      children = [
        SimpleQueue
      ]
  
      Supervisor.init(children, strategy: :one_for_one)
    end
  end


 

# SimpleQueue.child_spec

# Queue.Supervisor.start_link([])   # supervisor start

# :observer.start   # process 구성 확인 

# {_, {_, pid}} =  SimpleQueue.start_link([1, 2, 3])  # 또는 
# pid = Process.whereis(SimpleQueue)


# process 죽이기 
# Process.exit(pid, :kill)

# SimpleQueue GenServer Process 재시작 확인 




