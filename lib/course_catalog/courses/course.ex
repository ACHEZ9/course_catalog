defmodule CourseCatalog.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Courses.Subject
  alias CourseCatalog.Courses.Course
  alias CourseCatalog.Courses.CourseSubject


  schema "courses" do
    field :code, :string
    field :credits, :integer
    field :description, :string
    field :name, :string
    field :term, :string

    many_to_many :subjects, Subject, join_through: CourseSubject

    timestamps()
  end

  @doc false
  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:term, :code, :name, :description, :credits])
    |> validate_required([:code, :name, :description])
  end
end
