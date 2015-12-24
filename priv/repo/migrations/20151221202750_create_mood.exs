defmodule Nikoniko.Repo.Migrations.CreateMood do
  use Ecto.Migration

  def change do
    create table(:moods) do
      add :value, :string

      timestamps
    end

  end
end
