defmodule Capybara.Users do
  def enrich(users) do
    Enum.map(users, fn user ->
      user
      |> Map.put(:role, "user")
      |> Map.put(:active, true)
      |> Map.put(:joined_at, Date.utc_today())
    end)
  end
end
