defmodule PhoenixCart.OrderView do
  use PhoenixCart.Web, :view
  import Ecto.Query

  def line_item_count(order_id) do
    query = from o in PhoenixCart.LineItem, where: o.order_id == ^order_id, select: count(o.id)
    [count] = PhoenixCart.Repo.all(query)
    count
  end
end
