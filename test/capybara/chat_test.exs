defmodule Capybara.ChatTest do
  use Capybara.DataCase

  alias Capybara.Chat

  describe "messages" do
    alias Capybara.Chat.Message

    import Capybara.ChatFixtures

    @invalid_attrs %{content: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end

  describe "chat_rooms" do
    alias Capybara.Chat.Room

    import Capybara.ChatFixtures

    @invalid_attrs %{name: nil}

    test "list_chat_rooms/0 returns all chat_rooms" do
      room = room_fixture()
      assert Chat.list_chat_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Chat.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Room{} = room} = Chat.create_room(valid_attrs)
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Room{} = room} = Chat.update_room(room, update_attrs)
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_room(room, @invalid_attrs)
      assert room == Chat.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Chat.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Chat.change_room(room)
    end
  end
end
