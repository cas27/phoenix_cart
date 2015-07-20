defmodule PhoenixCart.PageController do
  use PhoenixCart.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
