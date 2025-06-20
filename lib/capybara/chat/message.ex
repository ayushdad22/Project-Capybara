defmodule Capybara.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    belongs_to :room, Capybara.Chat.Room
    belongs_to :user, Capybara.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :room_id, :user_id])
    |> validate_required([:content, :room_id, :user_id])
  end
end
