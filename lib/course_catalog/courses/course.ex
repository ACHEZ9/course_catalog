defmodule CourseCatalog.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Courses.Course


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
    |> validate_required([:term, :code, :name, :description, :credits])
  end
end
