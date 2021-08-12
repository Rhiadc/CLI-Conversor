defmodule CliConversor.Interaction do
  defstruct currency_from: nil,
            currency_from_price: 1,
            name_currency_from: nil,
            currency_to: nil,
            currency_to_price: 1,
            name_currency_to: nil,
            amount: 1

  @spec add_amount_to_interaction(any) :: :ok
  def add_amount_to_interaction(amount) do
    interaction = CliConversor.Interaction.InteractionAgent.value
    interaction = %{ interaction | amount: amount}
    CliConversor.Interaction.InteractionAgent.add(interaction)
    amount
  end
end
