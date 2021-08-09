defmodule CliConversor.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)
    options
  end

  def generate_question(options) do
    opt = options
    |> Enum.with_index(1)
    |> Enum.map(fn {c,b} -> [b, c] end)
    |> Enum.map(fn g-> Enum.join(g, " - ") end)
    |> Enum.join(" | ")

    "Which one? [#{opt}]\n"
  end

  def parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
  end
end
