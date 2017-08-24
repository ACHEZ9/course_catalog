defmodule CourseCatalog.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :term, :string
      add :code, :string
      add :name, :string
      add :description, :string
      add :credits, :integer

      timestamps()
    end

  end
end
