defmodule FactoTask do

  def factorial(0), do: 1

  def factorial(x) do
    # Process.sleep(1000)
    x * factorial(x-1)
  end

end


# FactoTask.factorial(50_000)

# task = Task.async(FactoTask, :factorial, [50_000])
# Task.await(task)
# Task.yield(task,10)
