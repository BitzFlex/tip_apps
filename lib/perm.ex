defmodule Perm do
  @moduledoc false

  @doc false
  def perm([]) do
    [[]]
  end

  def perm(term) do
    for h <- term, t <- perm(term -- [h]), do: [h] ++ t
  end

  def test do
    perm([1,2,3])
    "Elixir" |> String.codepoints |> perm
  end

end
