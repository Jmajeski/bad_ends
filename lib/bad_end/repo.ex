defmodule BadEnd.Repo do
  use Ecto.Repo,
    otp_app: :bad_end,
    adapter: Ecto.Adapters.Postgres
end
