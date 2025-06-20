defmodule CapybaraWeb.ChatRoomLive do
  use CapybaraWeb, :live_view
  alias Capybara.Chat
  alias Capybara.Chat.Message

  def mount(%{"id" => room_id}, session, socket) do
    room = Chat.get_room!(room_id)
    messages = Chat.list_messages(room_id)
    if connected?(socket), do: Phoenix.PubSub.subscribe(Capybara.PubSub, "room:#{room_id}")
    user = Capybara.Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     assign(socket,
       room: room,
       messages: messages,
       message: "",
       user: user,
       error: nil
     )}
  end

  def handle_event("send_message", %{"content" => content}, socket) do
    user = socket.assigns.user
    room = socket.assigns.room

    attrs = %{
      content: content,
      user_id: user.id,
      room_id: room.id
    }

    case Chat.create_message(attrs) do
      {:ok, message} ->
        Phoenix.PubSub.broadcast(Capybara.PubSub, "room:#{room.id}", {:new_message, message})

        {:noreply,
         socket
         |> update(:messages, fn msgs -> msgs ++ [message] end)
         |> assign(message: "", error: nil)}

      {:error, _changeset} ->
        {:noreply, assign(socket, error: "Failed to send message")}
    end
  end

  def handle_info({:new_message, msg}, socket) do
    if Enum.any?(socket.assigns.messages, &(&1.id == msg.id)) do
      {:noreply, socket}
    else
      {:noreply, update(socket, :messages, fn messages -> messages ++ [msg] end)}
    end
  end

end
