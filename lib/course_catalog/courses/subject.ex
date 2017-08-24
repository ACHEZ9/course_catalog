defmodule CourseCatalog.Courses.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Courses.Subject


  schema "subjects" do
    field :abbreviation, :string
    field :name, :string
    field :term, :string

    many_to_many :courses, Course, join_through: CourseSubject

    timestamps()
  end

  @doc false
  def changeset(%Subject{} = subject, attrs) do
    subject
    |> cast(attrs, [:term, :name, :abbreviation])
    |> validate_required([:term, :name, :abbreviation])
  end
end
