defmodule CourseCatalog.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :term, :string
      add :code, :string
      add :name, :string
      add :description, :text #For values >255. Can remain :string in schema file
      add :credits, :integer

      timestamps()
    end

  end
end
