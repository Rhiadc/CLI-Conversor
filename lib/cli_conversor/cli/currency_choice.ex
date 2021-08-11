defmodule CliConversor.CLI.CurrencyChoice do
  alias CliConversor.Currency.CurrencyServices
  alias Mix.Shell.IO, as: Shell
  import CliConversor.CLI.BaseCommands


  def start do
    Shell.cmd("clear")
    IO.puts "===================== MOEDAS ========================"


    total_list = CliConversor.Currency.CurrencyAgent.value
    find_currency_by_index = &Enum.at(total_list, &1)
    interaction = CliConversor.Interaction.InteractionAgent.value

    answer =
      total_list
    |> Enum.map(&(&1.asset_id))
    |> generate_question
    |> Shell.prompt
    |> Integer.parse

    case answer do
      :error ->
        display_invalid_option()
        start()
      {option, _} ->
        find_currency_by_index.(option - 1) |> confirm_currency(interaction)
    end


  end


  defp confirm_currency(chosen_currency, interaction) do
    Shell.cmd("clear")
    Shell.info("Selected currency: " <> chosen_currency.name)
    if Shell.yes?("Confirm?"), do: modify_struct(chosen_currency, interaction), else: start()
  end


  defp modify_struct(chosen_currency, %{currency_from: nil, name_currency_from: nil} = interaction) do
    %{
      interaction |
      currency_from: chosen_currency.asset_id,
      name_currency_from: chosen_currency.name,
      currency_from_price: chosen_currency.price_usd
    }
    |> CliConversor.Interaction.InteractionAgent.add |> select_currency_to()
  end

  defp modify_struct(chosen_currency, %{currency_to: nil, name_currency_to: nil} = interaction) do
    %{
      interaction |
      currency_to: chosen_currency.asset_id,
      name_currency_to: chosen_currency.name,
      currency_to_price: chosen_currency.price_usd
    }
    |> CliConversor.Interaction.InteractionAgent.add
  end

  defp select_currency_to(_interaction) do
    Shell.info("Please, select the currency you want to convert to.")
    start()
  end


end
