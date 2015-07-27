defmodule PhoenixCart.Order do
  use PhoenixCart.Web, :model

  schema "orders" do
    field :ship_name, :string
    field :ship_company, :string
    field :ship_state, :string
    field :ship_zipcode, :string
    field :phone_number, :string
    field :email, :string
    field :status, :string
    field :total, :decimal
    field :ship_address1, :string
    field :ship_address2, :string

    field :card_number, :string, virtual: true

    has_many :line_items, PhoenixCart.LineItem
    has_many :products, through: [:line_items, :product]

    timestamps
  end

  @required_fields ~w(ship_name ship_state ship_zipcode phone_number email status total ship_address1)
  @optional_fields ~w(ship_address2 ship_company card_number)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(_,_, params \\ :empty)
  def changeset(:update, model, params) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def changeset(:checkout, model, params) do
    model
    |> cast(params, @required_fields ++ ["card_number"], @optional_fields)
  end

  def changeset(:create, model, params) do
    model
    |> cast(params, ["status"], @optional_fields)
  end

  def changeset(:new, model, params) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
