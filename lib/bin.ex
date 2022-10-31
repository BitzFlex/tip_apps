defmodule Bin do
  @moduledoc """
  Documentation for Perm.
  """



  @doc false
  def encode(packet_value,dup,qos,retain) do
    <<packet_value::size(4), dup::size(1), qos::size(2), retain::size(1)>>
  end

  def decode(<<packet_value::size(4), dup::size(1), qos::size(2), retain::size(1)>>) do
    IO.puts "Value : #{packet_value} , #{dup} , #{qos}, #{retain}"
  end

  def decode(list) when is_list(list) do
    list
      |> Enum.join(" ")
      |> IO.puts
  end

  def decode(_) do
    IO.puts "Invalid Param"
  end

  def test do
    data = <<3::size(4),1::size(1),2::size(2),1::size(1)>>
    decode(data)

    decode(<<0x3d>>)

    encode(3,1,2,1) |> decode

    decode([1,2,3])

    decode(%{"a" => 1})
  end
end
