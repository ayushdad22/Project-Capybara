defmodule CapybaraWeb.RoomLive do
  use CapybaraWeb, :live_view
  alias Capybara.Chat
  # def mount(%{"id" => room_id}, _session, socket) do
  #   room = Chat.get_room!(room_id)
  #   messages = Chat.list_messages(room_id) # implement this function to get room messages
  #   if connected?(socket), do: Phoenix.PubSub.subscribe(Capybara.PubSub, "room:#{room_id}")

  #   {:ok, assign(socket, room: room, messages: messages, new_message: "")}
  # end

  # def handle_event("send_message", %{"content" => content}, socket) do
  #   user = socket.assigns.current_user
  #   room = socket.assigns.room

  #   attrs = %{
  #     content: content,
  #     user_id: user.id,
  #     room_id: room.id
  #   }

  #   case Chat.create_message(attrs) do
  #     {:ok, message} ->
  #       # maybe update messages list and clear input
  #       {:noreply, update(socket, :messages, fn msgs -> msgs ++ [message] end)}

  #     {:error, changeset} ->
  #       {:noreply, assign(socket, error: "Failed to send message")}
  #   end
  # end

  # def handle_info({:new_message, message}, socket) do
  #   {:noreply, update(socket, :messages, fn msgs -> msgs ++ [message] end)}
  # end

  def mount(_params, %{"user_token" => user_token}, socket) do
    user = Capybara.Accounts.get_user_by_session_token(user_token)

    if user do
      rooms = Capybara.Chat.list_rooms_for_user(user)
      {:ok, assign(socket, user: user, rooms: rooms)}
    else
      {:ok, redirect(socket, to: "/login")}
    end
  end


end
