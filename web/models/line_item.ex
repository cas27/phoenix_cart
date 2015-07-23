defmodule PhoenixCart.LineItem do
  use PhoenixCart.Web, :model

  schema "line_items" do
    field :quantity, :integer
    field :price, :decimal
    belongs_to :product, PhoenixCart.Product
    belongs_to :order, PhoenixCart.Order

    timestamps
  end

  @required_fields ~w(quantity price order_id product_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
