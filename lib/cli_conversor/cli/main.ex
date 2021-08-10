defmodule CliConversor.CLI.Main do

  alias Mix.Shell.IO, as: Shell

  @spec start_conversor :: :ok
  def start_conversor do
    welcome_message()
    Shell.prompt("Press Enter to continue")
    currency_choice()
  end

  defp welcome_message do
    Shell.info("===============================================================")
    Shell.info("=============~~~ Conversor de Moedas e Criptos ~~~=============")
    Shell.info("===============================================================\n")
    Shell.info("Você poderá fazer consultas e armazena-las em um arquivo TXT...")
    Shell.info("Para consultar o arquivo, digite HISTORY ao sair.")
    Shell.info("Comece escolhendo sua moeda de referência (escolha pelo número): ")
  end

  defp currency_choice do
    value =
    CliConversor.CLI.CurrencyChoice.start()
  end
end
