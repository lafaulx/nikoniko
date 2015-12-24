defmodule Nikoniko.StatsController do
  use Nikoniko.Web, :controller

  alias Nikoniko.Stat

  def index(conn, _params) do
    stats = Repo.all(Stat)

    conn
    |> assign(:stats, stats)
    |> render "index.html"
  end
end
