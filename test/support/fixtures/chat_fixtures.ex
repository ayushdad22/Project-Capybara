defmodule Capybara.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Capybara.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Capybara.Chat.create_message()

    message
  end

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Capybara.Chat.create_room()

    room
  end
end
