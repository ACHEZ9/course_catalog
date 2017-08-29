defmodule CourseCatalog.Repo.Migrations.CreateCourseSubjects do
  use Ecto.Migration

  def change do
    create table(:course_subjects) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :subject_id, references(:subjects, on_delete: :delete_all)

      timestamps()
    end

    create index(:course_subjects, [:course_id])
    create index(:course_subjects, [:subject_id])
  end
end
