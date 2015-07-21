defmodule PhoenixCart.OrderControllerTest do
  use PhoenixCart.ConnCase

  alias PhoenixCart.Order
  @valid_attrs %{email: "some content", phone_number: "some content", ship_address1: "some content", ship_address2: "some content", ship_company: "some content", ship_name: "some content", ship_state: "some content", ship_zipcode: "some content", status: "some content", total: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing orders"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, order_path(conn, :new)
    assert html_response(conn, 200) =~ "New order"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, order_path(conn, :create), order: @valid_attrs
    assert redirected_to(conn) == order_path(conn, :index)
    assert Repo.get_by(Order, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_path(conn, :create), order: @invalid_attrs
    assert html_response(conn, 200) =~ "New order"
  end

  test "shows chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = get conn, order_path(conn, :show, order)
    assert html_response(conn, 200) =~ "Show order"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, order_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = get conn, order_path(conn, :edit, order)
    assert html_response(conn, 200) =~ "Edit order"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = put conn, order_path(conn, :update, order), order: @valid_attrs
    assert redirected_to(conn) == order_path(conn, :index)
    assert Repo.get_by(Order, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = put conn, order_path(conn, :update, order), order: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit order"
  end

  test "deletes chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = delete conn, order_path(conn, :delete, order)
    assert redirected_to(conn) == order_path(conn, :index)
    refute Repo.get(Order, order.id)
  end
end
