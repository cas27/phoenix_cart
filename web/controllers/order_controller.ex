defmodule PhoenixCart.OrderController do
  use PhoenixCart.Web, :controller

  alias PhoenixCart.Order

  plug :scrub_params, "order" when action in [:create, :update]

  def index(conn, _params) do
    orders = Repo.all(Order)
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    changeset = Order.changeset(:new, %Order{status: "cart"})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    changeset = Order.changeset(:create, %Order{}, order_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Order created successfully.")
      |> redirect(to: order_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(:update, order, order_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Order updated successfully.")
      |> redirect(to: order_path(conn, :index))
    else
      render(conn, "edit.html", order: order, changeset: changeset)
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
