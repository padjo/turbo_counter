## TurboCouner  -- simple liveview/phoenix/elixir app that ad's a counter to the browser that's updated every second and teaches creating state on the socket via the mount function , changing state via a :timer.send_interval(ms,self(),msg)function called every x milliseconds which will need to be handled and the state change by the handle_info function which changes the count value on the socket and triggers a browser update of just that variable. 

This is a code along to the groxio first liveview video see https://grox.io/language/liveview/course for the 1st video which is on youtube, the rest 
are hosted on the groxio website which requires course payment. 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
