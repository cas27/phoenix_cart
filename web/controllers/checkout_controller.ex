defmodule PhoenixCart.CheckoutController do
  use PhoenixCart.Web, :controller

  alias PhoenixCart.Order
  alias PhoenixCart.LineItem

  import Ppt

  plug :scrub_params, "order" when action in [:update]
  plug PhoenixCart.Plugs.Cart when action in [:index]

  def index(conn, _params) do
    changeset = Order.changeset(:update, conn.assigns[:order])
    render(conn, "index.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(:checkout, order, order_params)

    if changeset.valid? and card_processes?(order_params) do
      Repo.update!(changeset)

      conn
      |> redirect(to: cart_path(conn, :index))
    else
      render(conn, "index.html", order: order, changeset: changeset)
    end
  end

  defp card_processes?(%{"card_number" => card_number, "exp_month" => exp_month, "exp_year" => exp_year, "cvc" => cvc}) do
    card = %{
      number: card_number,
      type: "mastercard",
      expire_year: exp_year,
      expire_month: exp_month,
      cvv2: cvc
       }
    transaction = %{total: "200.99", description: "Some Items"}

    response = purchase(card, transaction)
    IO.inspect response

    case response do
      %{status_code: 201} -> true
      _ -> false
    end
  end

end
