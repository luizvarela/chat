defmodule Chat.RoomController do
  use Chat.Web, :controller

  def create(conn, params) do
    roomname = params["room"]["roomname"]

    conn
      |> put_session(:username, params["room"]["username"])
      |> redirect(to: "/rooms/#{roomname}")
  end

  def show(conn, params) do
    conn
      |> assign(:username, get_session(conn, :username))
      |> assign(:room, params["id"])
      |> render(:show)
  end

  def private(conn, _params) do
    redirect conn, to: "/rooms/#{random_room_name}"
  end

  defp random_room_name do
    :crypto.strong_rand_bytes(32)
      |> Base.hex_encode32
  end
end
