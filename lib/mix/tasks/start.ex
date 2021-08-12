defmodule Mix.Tasks.Start do
  use Mix.Task.Compiler

  def run(_) do
    Mix.Task.run("app.start")
    CliConversor.CLI.Main.start_conversor
  end
end
