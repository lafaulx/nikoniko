defmodule Nikoniko.MoodView do
  use Nikoniko.Web, :view

  def render("index.json", %{moods: moods}) do
    %{data: render_many(moods, Nikoniko.MoodView, "mood.json")}
  end

  def render("show.json", %{mood: mood}) do
    %{data: render_one(mood, Nikoniko.MoodView, "mood.json")}
  end

  def render("mood.json", %{mood: mood}) do
    %{id: mood.id,
      value: mood.value,
      date: mood.inserted_at}
  end
end
