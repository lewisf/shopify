defmodule Shopify.Payment do
  @derive [Poison.Encoder]
  @singular "payment"
  @plural "payments"

  use Shopify.Resource

  alias Shopify.{
    Payment
  }

  defstruct [
    :request_details,
    :amount,
    :session_id,
    :unique_token
  ]

  @doc false
  def empty_resource do
    %Payment{}
  end

  @doc false
  def create_url(token), do: "checkouts/#{token}/payments.json"

  @doc false
  def all_url(token), do: "checkouts/#{token}/payments.json"

  @doc false
  def count_payments_url(token), do: "checkouts/#{token}/payments/count.json"

  @doc false
  def find_payment_url(token, payment_id),
    do: "checkouts/#{token}/payments/#{payment_id}/payments.json"

  def create(session, token, body) do
    session
    |> Request.new(create_url(token), body)
    |> Client.post()
  end

  @spec payments(%Shopify.Session{}, binary) :: {:ok, %__MODULE__{}} | {:error, map}
  def payments(session, token) do
    session
    |> Request.new(all_url(token), [])
    |> Client.get()
  end

  @spec count(%Shopify.Session{}, binary) :: {:ok, %__MODULE__{}} | {:error, map}
  def count(session, token) do
    session
    |> Request.new(count_payments_url(token), nil)
    |> Client.get()
  end

  @spec find_payment(%Shopify.Session{}, binary, binary) :: {:ok, %__MODULE__{}} | {:error, map}
  def find_payment(session, token, payment_id) do
    session
    |> Request.new(find_payment_url(token, payment_id), empty_resource())
    |> Client.get()
  end
end
