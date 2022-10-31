defmodule RecurTest do

  def tail_test(1) do
    1
  end

  def tail_test(no) do
    tail_test(no-1) + 1
  end


  def tail_test2(1) do
    1
  end

  def tail_test2(no) do
    1 + tail_test(no-1)
  end


  def tail_test3(0,sum) do
    sum
  end

  def tail_test3(no,sum) do
    tail_test3(no-1,sum+1)
  end

  def tail_test3(no) do
    tail_test3(no,0)
  end


  def benchee do


    Benchee.run(
      %{
        "tail_test" => fn -> tail_test(100_000) end,
        "tail_test2" => fn -> tail_test2(100_000) end,
        "tail_test3" => fn -> tail_test3(100_000) end
      },
      time: 10,
      memory_time: 2
    )
  end



end
