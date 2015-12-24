defmodule Nikoniko.Stat do
  use Nikoniko.Web, :model

  @primary_key {:date, Ecto.Date, []}
  @derive {Phoenix.Param, key: :date}

  schema "stats" do
    field :good, :integer
    field :neutral, :integer
    field :bad, :integer
  end

  @required_fields ~w(date good neutral bad)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
