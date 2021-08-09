defmodule CliConversor.Interaction do
  defstruct currency_from: nil,
            name_currency_from: nil,
            currency_to: nil,
            name_currency_to: nil,
            amount: 1,
            swap: false,
            exit: false
end
