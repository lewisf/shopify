defmodule Shopify.ShippingRate do
  @derive [Poison.Encoder]
  @singular "shipping_rate"
  @plural "shipping_rates"

  use Shopify.Resource

  alias Shopify.{
    ShippingRate,
    Checkout
  }

  defstruct [
    :id,
    :price,
    :title,
    :checkout,
    :phone_required,
    :delivery_range,
    :handle
  ]

  @doc false
  def empty_resource do
    %ShippingRate{
      checkout: %Checkout{}
    }
  end

  @doc """
  Retrieves a list of shipping rates for a token.

  Returns `{:ok, %Shopify.Response{}}` or `{:error, %Shopify.Response{}}`

  ## Parameters
    - session: A `%Shopify.Session{}` struct.
    - token: A checkout token.

  ## Examples
      iex> Shopify.session |> Shopify.ShippingRates.all("asdfasdfasdf")
      {:ok, %Shopify.Response{}}
  """
  @spec all(%Shopify.Session{}, binary) :: {:ok, %__MODULE__{}} | {:error, map}
  def all(session, token) do
    session
    |> Request.new(@plural <> "/#{token}/shipping_rates.json", empty_resource())
    |> Client.get()
  end
end
