defmodule Shopify.ShippingRate.Checkout do
  @derive [Poison.Encoder]

  defstruct [
    :total_tax,
    :total_price,
    :subtotal_price
  ]
end
