defmodule PhoenixCart.Router do
  use PhoenixCart.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCart do
    pipe_through :browser # Use the default browser stack

    resources "/categories", CategoryController
    resources "/products", ProductController
    resources "/orders", OrderController
    resources "/cart", CartController, only: [:index, :update, :delete] 

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCart do
  #   pipe_through :api
  # end
end
