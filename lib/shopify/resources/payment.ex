defmodule Shopify.Payment do
  @derive [Poison.Encoder]
  @singular "checkout"
  @plural "checkouts"

  use Shopify.Resource,
    import: [
      :find,
      :all,
      :count,
      :create
    ]

  alias Shopify.{
    Payment
  }

  defstruct [
    :request_details,
    :amount,
    :session_id,
    :credit_card,
    :id,
    :payment_processing_error_message,
    :transaction,
    :unique_token
  ]

  @doc false
  def empty_resource do
    %Payment{}
  end

  @doc false
  def find_url(id), do: @plural <> "/#{id}.json"

  @doc false
  def all_url, do: @plural <> ".json"

  @doc false
  def count_url, do: @plural <> "/count.json"
end
