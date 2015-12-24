defmodule Nikoniko.MoodControllerTest do
  use Nikoniko.ConnCase

  alias Nikoniko.Mood
  @valid_attrs %{value: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, mood_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mood = Repo.insert! %Mood{}
    conn = get conn, mood_path(conn, :show, mood)
    assert json_response(conn, 200)["data"] == %{"id" => mood.id,
      "value" => mood.value}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, mood_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, mood_path(conn, :create), mood: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Mood, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, mood_path(conn, :create), mood: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mood = Repo.insert! %Mood{}
    conn = put conn, mood_path(conn, :update, mood), mood: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Mood, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    mood = Repo.insert! %Mood{}
    conn = put conn, mood_path(conn, :update, mood), mood: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    mood = Repo.insert! %Mood{}
    conn = delete conn, mood_path(conn, :delete, mood)
    assert response(conn, 204)
    refute Repo.get(Mood, mood.id)
  end
end
