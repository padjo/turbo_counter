defmodule TurboCouner.Repo do
  use Ecto.Repo,
    otp_app: :turbo_couner,
    adapter: Ecto.Adapters.Postgres
end
