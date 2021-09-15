defmodule TurboCounerWeb.CountLive do
  use TurboCounerWeb, :live_view

  alias TurboCounter.Counters

  def mount(_params, _session, socket) do

    {:ok, socket |> new }
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  defp add_counter(socket) do
    assign(socket, counters: Counters.add_counter(socket.assigns.counters))
  end

  def render(assigns) do
    ~L"""
    <hr>
    <%= for {name, count} <- @counters do %>
      name <%= name %> : Count <%= count %>
          <button phx-click="inc" phx-value-name="<%= name %>">inc</button>
          | <button phx-click="dec" phx-value-name="<%= name %>">dec</button>
          | <button phx-click="clear" phx-value-name="<%= name %>">clear</button>
    </p>
    <% end %>

    <button phx-click="add" >add</button>
    """
  end

  defp inc_count(socket,name) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, name))
  end

  defp dec_count(socket,name) do
    assign(socket, counters: Counters.dec(socket.assigns.counters, name))
  end

  defp clear_count(socket,name) do
    assign(socket, counters: Counters.clear(socket.assigns.counters, name))
  end

  def handle_event("inc", %{"name" => name}, socket) do
    {:noreply, inc_count(socket,name)}
  end

  def handle_event("dec", %{"name" => name}, socket) do
    {:noreply, dec_count(socket,name)}
  end

  def handle_event("clear", %{"name" => name}, socket) do
    {:noreply, clear_count(socket,name)}
  end

  def handle_event("add", _, socket) do
    {:noreply, add_counter(socket)}
  end
end
