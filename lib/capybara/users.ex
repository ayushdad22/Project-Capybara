defmodule Capybara.Users do
  def enrich(users) do
    Enum.map(users, fn user ->
      user
      |> Map.put(:role, "user")
      |> Map.put(:active, true)
      |> Map.put(:joined_at, Date.utc_today())
    end)
  end
  def find_A(users) do
    Enum.filter(users, fn user -> String.starts_with?(user.name, "A") end)
  end
end
