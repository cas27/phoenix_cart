defmodule PhoenixCart.ProductView do
  use PhoenixCart.Web, :view

  def categories_for_select do
    PhoenixCart.Repo.all(PhoenixCart.Category)
    |> Enum.map &({&1.name, &1.id})
  end
end
