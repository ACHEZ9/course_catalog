defmodule CourseCatalog.Courses.CourseSubject do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Courses.CourseSubject


  schema "course_subjects" do
    belongs_to :course, Course
    belongs_to :subject, Subject
    # field :course_id, :id
    # field :subject_id, :id

    timestamps()
  end

  @doc false
  def changeset(%CourseSubject{} = course_subject, attrs) do
    course_subject
    |> cast(attrs, [])
    |> validate_required([])
  end
end
