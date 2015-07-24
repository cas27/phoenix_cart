defmodule PhoenixCart.CartView do
  use PhoenixCart.Web, :view

  def line_item_total(li) do
    Decimal.mult(li.price, Decimal.new(li.quantity))
  end
end
