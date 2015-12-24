defmodule Nikoniko.MoodController do
  use Nikoniko.Web, :controller

  alias Nikoniko.Mood

  plug :scrub_params, "mood" when action in [:create, :update]

  def index(conn, _params) do
    moods = Repo.all(Mood)
    render(conn, "index.json", moods: moods)
  end

  def create(conn, %{"mood" => mood_params}) do
    changeset = Mood.changeset(%Mood{}, mood_params)

    case Repo.insert(changeset) do
      {:ok, mood} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", mood_path(conn, :show, mood))
        |> put_resp_cookie("mood_submission_date", Ecto.DateTime.to_string(mood.inserted_at), [
          http_only: true,
          max_age: 999999
        ])
        |> render("show.json", mood: mood)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Nikoniko.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mood = Repo.get!(Mood, id)
    render(conn, "show.json", mood: mood)
  end
end
