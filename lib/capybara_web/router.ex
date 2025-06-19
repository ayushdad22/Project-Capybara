defmodule CapybaraWeb.Router do
  use CapybaraWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CapybaraWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CapybaraWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # 👇 Add your LiveView route under this new scope
  scope "/a", CapybaraWeb do
    pipe_through :browser

    live "/counter", CounterLive
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:capybara, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CapybaraWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
