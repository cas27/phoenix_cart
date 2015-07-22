defmodule PhoenixCart.LineItemTest do
  use PhoenixCart.ModelCase

  alias PhoenixCart.LineItem

  @valid_attrs %{order: nil, price: "120.5", product: nil, quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
