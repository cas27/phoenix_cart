defmodule PhoenixCart.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :ship_name, :string
      add :ship_company, :string
      add :ship_state, :string
      add :ship_zipcode, :string
      add :phone_number, :string
      add :email, :string
      add :status, :string
      add :total, :decimal, [precision: 8, scale: 2]
      add :ship_address1, :string
      add :ship_address2, :string

      timestamps
    end

  end
end
