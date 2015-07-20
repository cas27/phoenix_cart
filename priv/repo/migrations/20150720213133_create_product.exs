defmodule PhoenixCart.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal, [scale: 2, precision: 8]
      add :description, :text
      add :category_id, :integer

      timestamps
    end

  end
end
