defmodule Nikoniko.Repo.Migrations.CreateStat do
  use Ecto.Migration

  def up do
    execute("CREATE VIEW stats AS
    SELECT
      COALESCE(goodandneutral.date, bad.date) AS date, COALESCE(good, 0) AS good, COALESCE(neutral, 0) AS neutral, COALESCE(bad, 0) AS bad
      FROM
        (SELECT
        COALESCE(good.date, neutral.date) date, COALESCE(good, 0) good, COALESCE(neutral, 0) neutral
        FROM (SELECT DATE(inserted_at), COUNT(value) AS good FROM moods WHERE moods.value='good' GROUP BY DATE(inserted_at), value) AS good
        FULL OUTER JOIN (SELECT DATE(inserted_at), COUNT(value) AS neutral FROM moods WHERE moods.value='neutral' GROUP BY DATE(inserted_at), value) AS neutral
        ON good.date = neutral.date) goodandneutral
      FULL OUTER JOIN (SELECT DATE(inserted_at), COUNT(value) AS bad FROM moods WHERE moods.value='bad' GROUP BY DATE(inserted_at), value) AS bad
      ON goodandneutral.date = bad.date ORDER BY date DESC;")
  end

  def down do
    execute("DROP VIEW stats;")
  end
end
