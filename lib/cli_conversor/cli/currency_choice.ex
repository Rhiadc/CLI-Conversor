defmodule CliConversor.CLI.CurrencyChoice do
  alias CliConversor.Currency.CurrencyServices
  alias CliConversor.Interaction
  alias Mix.Shell.IO, as: Shell
  import CliConversor.CLI.BaseCommands

  @spec start :: none
  def start do
    #Shell.cmd("clear")
    Shell.info("===================== MOEDAS ========================")

    crypto = CurrencyServices.get_crypto_list
    currency = CurrencyServices.get_currency_list
    total_list = crypto ++ currency
    find_currency_by_index = &Enum.at(total_list, &1)
    interaction = CliConversor.Interaction.InteractionAgent.value

    total_list
    |> Enum.map(&(&1.asset_id))
    #|> display_options
    |> generate_question
    |> Shell.prompt
    |> parse_answer
    |> find_currency_by_index.()
    |> confirm_currency(interaction)
  end

  #defp verify_
  defp confirm_currency(chosen_currency, interaction) do
    Shell.cmd("clear")
    Shell.info("Selected curressncy: " <> chosen_currency.name)
    if Shell.yes?("Confirm?"), do: modify_struct(chosen_currency, interaction), else: start()
  end


  defp modify_struct(chosen_currency, %{currency_from: nil, name_currency_from: nil} = interaction) do
    _interaction = %{
      interaction |
      currency_from: chosen_currency.asset_id,
      name_currency_from: chosen_currency.name
    }
    |> CliConversor.Interaction.InteractionAgent.add |> select_currency_to()
  end

  defp modify_struct(chosen_currency, %{currency_to: nil, name_currency_to: nil} = interaction) do
    interaction = %{
      interaction |
      currency_to: chosen_currency.asset_id,
      name_currency_to: chosen_currency.name
    }
    |> CliConversor.Interaction.InteractionAgent.add
    interaction
  end

  defp select_currency_to(_interaction) do
    Shell.info("Please, select the currency you want to convert to.")
    start()
  end
end
