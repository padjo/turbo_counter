defmodule TurboCounerWeb.CountLive do
  use TurboCounerWeb, :live_view

  alias TurboCounter.Counters

  def mount(_params, _session, socket) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, socket |> new |> add_counter(:tick, 0)}
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  defp add_counter(socket, name, count) do
    assign(socket, counters: Counters.add_counter(socket.assigns.counters, name, count))
  end

  def render(assigns) do
    ~L"""

    <h1> count is <%=@counters.tick%></h1>
    """
  end

  defp inc_count(socket, name) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, name))
  end

  def handle_info(name, socket) do
    {:noreply, inc_count(socket, name)}
  end
end
