defmodule PhoenixCart.Repo.Migrations.CreateLineItem do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :quantity, :integer
      add :price, :decimal, [scale: 2, precision: 8]
      add :product_id, :integer
      add :order_id, :integer

      timestamps
    end
    create index(:line_items, [:product_id])
    create index(:line_items, [:order_id])

  end
end
