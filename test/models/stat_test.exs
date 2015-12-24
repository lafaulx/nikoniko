defmodule Nikoniko.StatTest do
  use Nikoniko.ModelCase

  alias Nikoniko.Stat

  @valid_attrs %{bad: 42, date: "2010-04-17", good: 42, neutral: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stat.changeset(%Stat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stat.changeset(%Stat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
