defmodule TurboCounerWeb.CountLive do
  use TurboCounerWeb, :live_view

  alias TurboCounter.Counters

  def mount(_params, _session, socket) do

    {:ok, socket |> new |> new_changeset}
  end

  defp new(socket) do

    assign(socket, counters: Counters.new())
  end

  defp new_changeset(socket) do
    assign(socket, changeset: Counters.validate_new_counter(socket.assigns.counters,%{}))
  end

  defp add_counter(socket, params) do
    if socket.assigns.changeset.valid?() do
      socket
      |> assign( counters: Counters.add_counter(socket.assigns.counters, params["name"]))
      |> new_changeset



      #changeset = Counters.validate_new_counter(socket.assigns.counters,%{})
      #assign(socket, changeset: changeset)

    else
      socket
    end

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

    <%= f = form_for @changeset, "#",
      phx_change: "validate",
      phx_submit: "add" %>

      <%= label f, :name %>
      <%= text_input f, :name %>
      <%= error_tag f, :name %>

      <%= submit "Add Counter",
       phx_disable_with: "Adding...",
       disabled: !@changeset.valid?() %>
    </form>
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

  defp validate(socket, params) do
    changeset = socket.assigns.counters
     |> Counters.validate_new_counter(params)
     |> Map.put( :action, :validate)

     assign(socket, changeset: changeset)
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

  def handle_event("validate", %{"counter" => params}, socket) do
    {:noreply, validate(socket, params)}
  end

  def handle_event("add", %{"counter" => params}, socket) do
    {:noreply, socket |> validate(params) |> add_counter(params)}
  end
end
