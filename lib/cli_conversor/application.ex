defmodule CliConversor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {CliConversor.Interaction.InteractionAgent, %CliConversor.Interaction{}},
      {CliConversor.Currency.CurrencyAgent, CliConversor.Currency.CurrencyServices.return_final_list}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CliConversor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
