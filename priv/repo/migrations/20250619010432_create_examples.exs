defmodule Capybara.Repo.Migrations.CreateExamples do
  use Ecto.Migration

  def change do
    create table(:examples) do
      add :count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
