defmodule CliConversor.Interaction.InteractionAgent do
  use Agent

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @spec value :: any
  def value do
    Agent.get(__MODULE__, fn state -> state end)
  end

  @spec add(any) :: :ok
  def add(list) do
    Agent.update(__MODULE__, fn _state -> list end)
  end

end
