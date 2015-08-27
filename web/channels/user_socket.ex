defmodule PhoenixCart.UserSocket do
  use Phoenix.Socket
  alias PhoenixCart.OrderView

  channel "carts:*", PhoenixCart.CartChannel

  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "cart", token) do
      {:ok, order_id} ->
        socket = assign(socket, :cart_count, OrderView.line_item_count(order_id))
        {:ok, socket}
      {:error, _} ->
        :error
    end
  end

  def id(_socket), do: nil

end
