defmodule CourseCatalog.Courses.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Courses.Subject
  alias CourseCatalog.Courses.Course
  alias CourseCatalog.Courses.CourseSubject


  schema "subjects" do
    field :abbreviation, :string
    field :name, :string
    field :term, :string
    field :subject_key, :string

    many_to_many :courses, Course, join_through: CourseSubject

    timestamps()
  end

  @doc false
  def changeset(%Subject{} = subject, attrs) do
    subject
    |> cast(attrs, [:term, :name, :abbreviation, :subject_key])
    |> validate_required([:name, :abbreviation, :subject_key])
  end
end
