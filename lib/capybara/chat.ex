defmodule Capybara.Chat do
  @moduledoc """
  The Chat context managing chat rooms and messages.
  """

  import Ecto.Query, warn: false
  alias Capybara.Repo

  alias Capybara.Chat.{Room, Message}

  # --- Rooms ---

  @doc "Returns all chat rooms"
  def list_rooms do
    Repo.all(Room)
  end

  @doc "Gets a room by ID, raises if not found"
  def get_room!(id), do: Repo.get!(Room, id)

  @doc "Creates a new chat room"
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates an existing chat room"
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a chat room"
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc "Returns a changeset for a room"
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  # --- Messages ---

  @doc "Returns messages for a given room, preloading users and sorted by insert time"
  def list_messages(room_id) do
    from(m in Message,
      where: m.room_id == ^room_id,
      preload: [:user],
      order_by: [asc: m.inserted_at]
    )
    |> Repo.all()
  end

  @doc "Gets a message by ID, raises if not found"
  def get_message!(id), do: Repo.get!(Message, id)

  @doc "Creates a new message"
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates an existing message"
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a message"
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc "Returns a changeset for a message"
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
