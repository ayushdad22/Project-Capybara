defmodule CapybaraWeb.CounterLive do
  use CapybaraWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: "Hello")}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 <>"I"))}
  end

  def handle_event("roll", _, socket) do
    {:noreply, assign(socket, count: Enum.random(1..6))}
  end
end
