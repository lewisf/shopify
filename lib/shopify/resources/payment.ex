defmodule Shopify.Payment do
  @derive [Poison.Encoder]
  @singular "payment"
  @plural "payments"

  use Shopify.Resource,
    import: [
      :all,
      :find,
      :create,
      :update,
      :count
    ]

  alias Shopify.{
    Checkout
  }

  defstruct [
    :abandoned_checkout_url,
    :billing_address,
    :buyer_accepts_marketing,
    :cancel_reason,
    :cart_token,
    :closed_at,
    :completed_at,
    :created_at,
    :currency,
    :customer,
    :discount_codes,
    :email,
    :gateway,
    :landing_site,
    :line_items,
    :note,
    :phone,
    :referring_site,
    :shipping_address,
    :shipping_line,
    :source_name,
    :subtotal_price,
    :tax_lines,
    :taxes_included,
    :token,
    :total_discounts,
    :total_line_items_price,
    :total_price,
    :total_tax,
    :total_weight,
    :updated_at,
    :order,
    :order_id,
    :customer_id,
    :location_id,
    :device_id,
    :shopify_payments_account_id,
    :user_id
  ]

  @doc false
  def empty_resource do
    %Checkout{
      billing_address: %BillingAddress{},
      shipping_address: %ShippingAddress{},
      customer: %Customer{
        default_address: %Address{}
      },
      line_items: [
        %LineItem{
          tax_lines: [%TaxLine{}]
        }
      ],
      shipping_line: %ShippingLine{},
      tax_lines: [%TaxLine{}],
      discount_codes: [%DiscountCode{}],
      order: %Checkout.Order{}
    }
  end

  @doc false
  def all_url, do: @plural <> ".json"

  @doc false
  def find_url(token), do: @plural <> "/#{token}.json"

  @doc false
  def count_url, do: @plural <> "/count.json"

  @doc """
  Creates a payment on a checkout using the session ID returned by the card vault.

  Returns `{:ok, %Shopify.Response{}}` or `{:error, %Shopify.Response{}}`

  ## Parameters
    - session: A `%Shopify.Session{}` struct.
    - token: A checkout token.

  ## Examples
      iex> Shopify.session |> Shopify.Checkout.payments("asdfasdfasdf")
      {:ok, %Shopify.Response{}}
  """
  @spec payments(%Shopify.Session{}, binary) :: {:ok, %__MODULE__{}} | {:error, map}
  def payments(session, token) do
    session
    |> Request.new("checkouts" <> "/#{token}/payments.json", empty_resource())
    |> Client.post()
  end
end
