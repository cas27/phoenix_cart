defmodule PhoenixCart.CartController do
  use PhoenixCart.Web, :controller

  alias PhoenixCart.Order
  alias PhoenixCart.Product
  alias PhoenixCart.LineItem

  plug :scrub_params, "line_item" when action in [:create, :update]
  plug PhoenixCart.Plugs.Cart when action in [:index]


  def index(conn, _params) do
    changeset = Order.changeset(:update, conn.assigns[:order])
    render(conn, "index.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "line_item" => line_item_params}) do
    order = Repo.get!(Order, id)
    product = Repo.get!(Product, line_item_params["product_id"])

    changeset = LineItem.changeset(%LineItem{}, line_item_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Added to cart.")
      |> redirect(to: cart_path(conn, :index))
    else
      conn
      |> redirect(to: product_path(conn, :show, product))
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
