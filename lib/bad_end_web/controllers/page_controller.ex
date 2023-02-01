defmodule BadEndWeb.PageController do
  use BadEndWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
