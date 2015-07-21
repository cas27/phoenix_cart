defmodule PhoenixCart.Plugs.Cart do
  import Plug.Conn
  alias PhoenixCart.Repo

  def init(default), do: default

  def call(conn, _default) do
    if get_session(conn, :cart) do
      cart = Repo.get(PhoenixCart.Order, get_session(conn, :cart))
      assign(conn, :order, cart)
    else
      cart = Repo.insert!(%PhoenixCart.Order{status: "cart"})
      conn = put_session(conn, :cart, cart.id)
      assign(conn, :order, cart)
    end
  end
end
