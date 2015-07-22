defmodule PhoenixCart.CartController do
  use PhoenixCart.Web, :controller

  alias PhoenixCart.Order
  alias PhoenixCart.Product
  alias PhoenixCart.LineItem

  plug :scrub_params, "line_item" when action in [:create, :update]


  def index(conn, _params) do
    orders = Repo.all(Order)
    render(conn, "index.html", orders: orders)
  end

  def update(conn, %{"id" => id, "line_item" => line_item_params}) do
    order = Repo.get!(Order, id)
    product = Repo.get!(Product, line_item_params["product_id"])
    changeset = LineItem.changeset(%LineItem{}, line_item_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Added to cart.")
      |> redirect(to: cart_path(conn, :index))
    else
      render(conn, "show.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    Repo.delete!(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: order_path(conn, :index))
  end
end
