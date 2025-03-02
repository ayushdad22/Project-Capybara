defmodule Capybara.Repo do
  use Ecto.Repo,
    otp_app: :capybara,
    adapter: Ecto.Adapters.Postgres
end
