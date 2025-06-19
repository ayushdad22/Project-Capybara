defmodule CapybaraWeb.CounterLive.Show do
  use CapybaraWeb, :live_view

  alias Capybara.Example

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:counter, Example.get_counter!(id))}
  end

  defp page_title(:show), do: "Show Counter"
  defp page_title(:edit), do: "Edit Counter"
end
