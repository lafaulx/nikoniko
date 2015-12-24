defmodule Nikoniko.ClientController do
  use Nikoniko.Web, :controller

  alias Ecto.DateTime
  alias Ecto.Date

  def index(conn, _params) do
    conn
    |> assign(:is_mood_submitted_today, is_mood_submitted_today(conn.cookies["mood_submission_date"]))
    |> render "index.html"
  end

  defp is_mood_submitted_today(nil) do
    false
  end

  defp is_mood_submitted_today(submission_datetime) do
    {:ok, submission_datetime_parsed} = DateTime.cast(submission_datetime)
    submission_date = DateTime.to_date(submission_datetime_parsed)

    case Date.compare(Date.utc(), submission_date) do
      :eq -> true
      _any -> false
    end
  end
end
