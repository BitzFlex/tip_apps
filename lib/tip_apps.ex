defmodule TipApps do
  use Application

  def start(_type, _args) do
    children = [
                  SimpleQueue,
                  {Task.Supervisor, [name: MQHandlerTaskSV, strategy: :one_for_one, max_restarts: 100, max_seconds: 10_000]},
    ]

    opts = [strategy: :one_for_one, name: TipApps.Supervisor]
    Supervisor.start_link(children, opts)
  end


  def taskProc(0) do
    # Process.exit(self(),:kill)
  end


  def taskProc(n) do
    Process.sleep(1_000)
    IO.puts "Task.. #{n}"

    taskProc(n-1)
  end

  def startTask do
    Task.Supervisor.start_child(MQHandlerTaskSV, fn->  taskProc(3) end, restart: :permanent)
  end


end
