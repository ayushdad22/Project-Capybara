defmodule CapybaraWeb.CounterLive.Index do
  use CapybaraWeb, :live_view

  alias Capybara.Example
  alias Capybara.Example.Counter

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :examples, Example.list_examples())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Counter")
    |> assign(:counter, Example.get_counter!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Counter")
    |> assign(:counter, %Counter{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Examples")
    |> assign(:counter, nil)
  end

  @impl true
  def handle_info({CapybaraWeb.CounterLive.FormComponent, {:saved, counter}}, socket) do
    {:noreply, stream_insert(socket, :examples, counter)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    counter = Example.get_counter!(id)
    {:ok, _} = Example.delete_counter(counter)

    {:noreply, stream_delete(socket, :examples, counter)}
  end
end
