# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CourseCatalog.Repo.insert!(%CourseCatalog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias CourseCatalog.Courses.Subject
alias CourseCatalog.Courses.Course
alias CourseCatalog.Courses
alias CourseCatalog.Courses.CourseSubject

CourseCatalog.Repo.delete_all(Subject)
CourseCatalog.Repo.delete_all(Course)

defmodule SeedHelper do

  def insertCourse(course) do
    {:ok, newCourse} = Courses.create_course(course)
    subjects = course["subjects"]
    |> Enum.each(&(insertCourseSubject(newCourse.id, &1)))
  end

  def insertSubject(subject) do
    Map.put(subject, "subject_key", Map.get(subject, "id"))
    |> Courses.create_subject
  end

  def insertCourseSubject(course_id, subject) do
    fetchedSubject = CourseCatalog.Repo.get_by(Subject, subject_key: subject["id"])
    if not is_nil(fetchedSubject) do
        %CourseSubject{}
        |> CourseSubject.changeset(%{course_id: course_id, subject_id: fetchedSubject.id})
        |> CourseCatalog.Repo.insert!()
    end
  end

end

subjects = File.read!("priv/static/subject.json") |> Poison.decode!()
courses = File.read!("priv/static/course.json") |> Poison.decode!()

subjects
|> Enum.each(&(SeedHelper.insertSubject(&1)))

courses
|> Enum.each(&(SeedHelper.insertCourse(&1)))
