defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_), do: CliConversor.CLI.Main.start_conversor
end
