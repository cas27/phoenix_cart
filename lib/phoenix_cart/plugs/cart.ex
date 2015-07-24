defmodule PhoenixCart.Plugs.Cart do
  import Plug.Conn
  import Ecto.Query
  alias PhoenixCart.Repo
  alias PhoenixCart.Order

  def init(default), do: default

  def call(conn, _default) do
    if get_session(conn, :cart) do
      [cart] = Repo.all(Ecto.Query.from(p in Order, where: p.id == ^get_session(conn, :cart)))
      |> Repo.preload([line_items: :product])
      assign(conn, :order, cart)
    else
      new_cart = Repo.insert!(%Order{status: "cart"})
      [cart] = Repo.all(Ecto.Query.from(p in Order, where: p.id == ^new_cart.id, preload: :line_items))
      conn = put_session(conn, :cart, cart.id)
      assign(conn, :order, cart)
    end
  end
end
