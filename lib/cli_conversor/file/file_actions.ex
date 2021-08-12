defmodule CliConversor.File.FileActions do
  @txt_path "history.txt"

  def write_and_return(value) do
    if File.exists?(@txt_path) do
      File.write(@txt_path, value, [:append])
    else
      starting_value = "Historico de conversões\n\n" <> value
      File.write!(@txt_path, starting_value)
    end
  end

  def get_history do
    {:ok, history} = File.read(@txt_path)
    IO.puts history
  end
end
