defmodule PhoenixCart.OrderTest do
  use PhoenixCart.ModelCase

  alias PhoenixCart.Order

  @valid_attrs %{email: "some content", phone_number: "some content", ship_address1: "some content", ship_address2: "some content", ship_company: "some content", ship_name: "some content", ship_state: "some content", ship_zipcode: "some content", status: "some content", total: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
