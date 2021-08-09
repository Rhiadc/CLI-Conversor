defmodule CliConversorTest do
  use ExUnit.Case
  doctest CliConversor

  test "greets the world" do
    assert CliConversor.hello() == :world
  end
end
