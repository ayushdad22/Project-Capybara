defmodule CapybaraWeb.RoomLive.Index do
  use CapybaraWeb, :live_view

  alias Capybara.Chat
  alias Capybara.Chat.Room

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :chat_rooms, Chat.list_chat_rooms())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Room")
    |> assign(:room, Chat.get_room!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Room")
    |> assign(:room, %Room{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Chat rooms")
    |> assign(:room, nil)
  end

  @impl true
  def handle_info({CapybaraWeb.RoomLive.FormComponent, {:saved, room}}, socket) do
    {:noreply, stream_insert(socket, :chat_rooms, room)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    room = Chat.get_room!(id)
    {:ok, _} = Chat.delete_room(room)

    {:noreply, stream_delete(socket, :chat_rooms, room)}
  end
end
