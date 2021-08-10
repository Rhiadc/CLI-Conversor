defmodule CliConversor.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  @spec display_options(any) :: any
  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)
    options
  end

  #perguntas (nova conversão, history, exit)
  @spec generate_question(any) :: <<_::64, _::_*8>>
  def generate_question(options) do
    opt = options
    |> Enum.with_index(1)
    |> Enum.map(fn {c,b} -> [b, c] end)
    |> Enum.map(fn g-> Enum.join(g, " - ") end)
    |> Enum.join(" | ")

    "Which one? [#{opt}]\n"
  end

  @spec parse_answer(binary) :: integer
  def parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
  end

  @spec parse_amount(binary) :: integer
  def parse_amount(amount) do
    {amount, _} = Integer.parse(amount)
    amount
  end

  @spec add_amount_to_interaction(any) :: :ok
  def add_amount_to_interaction(amount) do
    interaction = CliConversor.Interaction.InteractionAgent.value
    interaction = %{ interaction | amount: amount}
    CliConversor.Interaction.InteractionAgent.add(interaction)
  end
end
