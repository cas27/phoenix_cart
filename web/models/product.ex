defmodule PhoenixCart.Product do
  use PhoenixCart.Web, :model

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :description, :string
    belongs_to :category, Category

    timestamps
  end

  @required_fields ~w(name price description category_id)
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
