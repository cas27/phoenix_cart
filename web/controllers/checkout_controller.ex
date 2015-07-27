defmodule PhoenixCart.CheckoutController do
  use PhoenixCart.Web, :controller

  alias PhoenixCart.Order
  alias PhoenixCart.LineItem

  plug :scrub_params, "order" when action in [:update]
  plug PhoenixCart.Plugs.Cart when action in [:index]

  def index(conn, _params) do
    changeset = Order.changeset(:update, conn.assigns[:order])
    render(conn, "index.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(:checkout, order, order_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> redirect(to: cart_path(conn, :index))
    else
      render(conn, "index.html", order: order, changeset: changeset)
    end
  end

end
