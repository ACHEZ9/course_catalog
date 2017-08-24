defmodule CourseCatalog.CoursesTest do
  use CourseCatalog.DataCase

  alias CourseCatalog.Courses

  describe "courses" do
    alias CourseCatalog.Courses.Course

    @valid_attrs %{code: "some code", credits: 42, description: "some description", name: "some name", term: "some term"}
    @update_attrs %{code: "some updated code", credits: 43, description: "some updated description", name: "some updated name", term: "some updated term"}
    @invalid_attrs %{code: nil, credits: nil, description: nil, name: nil, term: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Courses.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Courses.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Courses.create_course(@valid_attrs)
      assert course.code == "some code"
      assert course.credits == 42
      assert course.description == "some description"
      assert course.name == "some name"
      assert course.term == "some term"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, course} = Courses.update_course(course, @update_attrs)
      assert %Course{} = course
      assert course.code == "some updated code"
      assert course.credits == 43
      assert course.description == "some updated description"
      assert course.name == "some updated name"
      assert course.term == "some updated term"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_course(course, @invalid_attrs)
      assert course == Courses.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Courses.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Courses.change_course(course)
    end
  end

  describe "subjects" do
    alias CourseCatalog.Courses.Subject

    @valid_attrs %{abbreviation: "some abbreviation", name: "some name", term: "some term"}
    @update_attrs %{abbreviation: "some updated abbreviation", name: "some updated name", term: "some updated term"}
    @invalid_attrs %{abbreviation: nil, name: nil, term: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Courses.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Courses.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = Courses.create_subject(@valid_attrs)
      assert subject.abbreviation == "some abbreviation"
      assert subject.name == "some name"
      assert subject.term == "some term"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, subject} = Courses.update_subject(subject, @update_attrs)
      assert %Subject{} = subject
      assert subject.abbreviation == "some updated abbreviation"
      assert subject.name == "some updated name"
      assert subject.term == "some updated term"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_subject(subject, @invalid_attrs)
      assert subject == Courses.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Courses.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Courses.change_subject(subject)
    end
  end
end
