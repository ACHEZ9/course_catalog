defmodule CourseCatalog.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :term, :string
      add :name, :string
      add :abbreviation, :string
      add :subject_key, :string

      timestamps()
    end

  end
end
