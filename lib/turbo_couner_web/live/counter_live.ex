defmodule TurboCounerWeb.CountLive do
  use TurboCounerWeb, :live_view

  def mount(_params, _session, socket) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, assign(socket, hello: :world, count: 0)}
  end

  def render(assigns) do
    ~L"""
    <h1>hello there <%=@hello%> </h1>
    <h1> count is <%=@count%></h1>
    """
  end

  def inc_count(socket) do
    assign(socket, count: socket.assigns.count + 1)
  end

  def handle_info(:tick, socket) do
    {:noreply, inc_count(socket)}
  end
end
