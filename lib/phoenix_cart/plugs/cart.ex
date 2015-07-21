defmodule PhoenixCart.Plugs.Cart do
  import Plug.Conn
  alias PhoenixCart.Repo
  alias PhoenixCart.Order

  def init(default), do: default

  def call(conn, _default) do
    if get_session(conn, :cart) do
      cart = Repo.get(Order, get_session(conn, :cart))
      assign(conn, :order, cart)
    else
      cart = Repo.insert!(%Order{status: "cart"})
      conn = put_session(conn, :cart, cart.id)
      assign(conn, :order, cart)
    end
  end
end
