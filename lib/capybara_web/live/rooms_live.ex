defmodule CapybaraWeb.RoomsLive do
  use CapybaraWeb, :live_view
  alias Capybara.Chat
  alias Capybara.Chat.Room

  def mount(_params, _session, socket) do
    rooms = Capybara.Chat.list_rooms()
    {:ok, assign(socket, rooms: rooms, new_room_name: "", error: nil, changeset: nil)}
  end

  def handle_event("validate", %{"room" => room_params}, socket) do
    changeset =
      %Room{}
      |> Chat.change_room(room_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("create_room", %{"room" => %{"name" => name}}, socket) do
    case Capybara.Chat.create_room(%{name: name}) do
      {:ok, _room} ->
        rooms = Capybara.Chat.list_rooms()
        {:noreply, assign(socket, rooms: rooms, new_room_name: "", error: nil)}

      {:error, changeset} ->
        rooms = Capybara.Chat.list_rooms()
        {:noreply,
         assign(socket,
           rooms: rooms,
           changeset: changeset,
           new_room_name: name,
           error: "Could not create room"
         )}
    end
  end


end
