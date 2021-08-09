defmodule CliConversor.Currency.CurrencyServices do
  alias CliConversor.Currency

  @url_crypto System.get_env("url_crypto")
  @url_currency System.get_env("url_currency")
  @api_key System.get_env("api_key")
  @headers ["X-CoinAPI-Key": @api_key, "Accept": "Application/json; Charset=utf-8"]


  defp api_fetch_call(url) do
    {:ok, response} = HTTPoison.get(url, @headers)
    response.body
    |> Poison.decode!
    |> Enum.map(fn item ->
        [item["asset_id"], item["name"], item["type_is_crypto"], item["price_usd"]]
      end)
  end


  def get_crypto_list do
    api_fetch_call(@url_crypto)
    |> order_list_by_name()
    |> generate_struct()


  end

  def get_currency_list do
    api_fetch_call(@url_currency)
    |> order_list_by_name()
    |> generate_struct()

  end

  defp generate_struct(list) do
    list
    |> Enum.into([],
      fn [asset, name, type, price] ->
        %Currency{asset_id: asset, name: name, type_is_crypto: type, price_usd: price}
      end)
  end

  defp generate_map_reference(list) do
    list
    |> Enum.into(%{}, fn [a, _b, _c, d] -> {a, d} end)
  end

  defp order_list_by_name(list) do
    list
    |> Enum.sort(&(&1 < &2))
    |> Enum.filter(fn [_asset, _name, _type, price] -> price != nil end)
  end
end
