defmodule CapybaraWeb.PageController do
  use CapybaraWeb, :controller
  alias Capybara.Users
  def home(conn, _params) do
      base_users = [
        %{id: 1, name: "Alice", email: "alice@example.com"},
        %{id: 2, name: "Ayush", email: "bob@example.com"},
        %{id: 3, name: "Charlie", email: "charlie@example.com"}
      ]

      users = Users.enrich(base_users)
      users_withA = Users.find_A(users)
      render(conn, :home, users: users, users_withA: users_withA, layout: false)
    end
  end
