defmodule TipAppsTest do
  use ExUnit.Case
  doctest TipApps

  test "greets the world" do
    assert TipApps.hello() == :world
  end
end
