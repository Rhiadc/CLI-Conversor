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

  @spec generate_question(any) :: <<_::64, _::_*8>>
  def generate_question(options) do
    opt = options
    |> Enum.with_index(1)
    |> Enum.map(fn {[id, name], index} -> [index, id, name] end)
    |> Enum.map(fn g-> Enum.join(g, " - ") end)
    |> Enum.join("\n ")

    "Escolha pelo numero da moeda: \n#{opt}\n"
  end

  def generate_question_menu(options) do
    opt = options
    |> Enum.with_index(1)
    |> Enum.map(fn {_c,b} -> [b] end)
    |> Enum.map(fn g-> Enum.join(g, ", ") end)
    |> Enum.join(", ")

    "Which one? [#{opt}]\n"
  end

  def menu_options do
    IO.puts("============== MENU ================")
    answer =
      ["Make another conversion", "Swap values", "View history", "Exit"]
    |> display_options()
    |> generate_question_menu()
    |> Shell.prompt
    |> Integer.parse

    case answer do
      :error ->
        display_invalid_option()
        menu_options()
      {option, _} ->
        CliConversor.CLI.Main.handle_answer(option - 1)
    end

  end

  def display_invalid_option do
    Shell.cmd("clear")
    Shell.error("Invalid Option")
    Shell.prompt("Press Enter to try again")
    Shell.cmd("clear")
  end

  def get_time_now do
    date_now = NaiveDateTime.utc_now
    string_date = "#{date_now.day}/#{date_now.month}/#{date_now.year} - "
    string_time = "#{date_now.hour}:#{date_now.minute}:#{date_now.second} - "
    string_date_time = string_date <> string_time
    string_date_time
  end
end
