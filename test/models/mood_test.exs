defmodule Nikoniko.MoodTest do
  use Nikoniko.ModelCase

  alias Nikoniko.Mood

  @valid_attrs %{value: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Mood.changeset(%Mood{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Mood.changeset(%Mood{}, @invalid_attrs)
    refute changeset.valid?
  end
end
