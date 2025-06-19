defmodule CapybaraWeb.CounterLive do
  use CapybaraWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _params, socket) do
    new_count = max(socket.assigns.count - 1, 0)
    {:noreply, assign(socket, :count, new_count)}
  end
end
