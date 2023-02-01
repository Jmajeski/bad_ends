import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bad_end, BadEnd.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bad_end_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bad_end, BadEndWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "TuS1dzcPFoZl5dVt4LcqD4hBaClGeuLjOTFU9wLghz4IHz6Bat6vd7wp6Ky3Ieaq",
  server: false

# In test we don't send emails.
config :bad_end, BadEnd.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
