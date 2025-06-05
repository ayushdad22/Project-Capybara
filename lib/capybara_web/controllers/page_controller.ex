defmodule CapybaraWeb.PageController do
  use CapybaraWeb, :controller
  alias Capybara.Users
  def home(conn, _params) do
      base_users = [
        %{id: 1, name: "Alice", email: "alice@example.com"},
        %{id: 2, name: "Bob", email: "bob@example.com"},
        %{id: 3, name: "Charlie", email: "charlie@example.com"}
      ]

      users = Users.enrich(base_users)

      render(conn, :home, users: users, layout: false)
    end
  end
