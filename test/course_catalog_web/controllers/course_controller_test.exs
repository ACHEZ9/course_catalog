defmodule CourseCatalogWeb.CourseControllerTest do
  use CourseCatalogWeb.ConnCase

  alias CourseCatalog.Courses

  @create_attrs %{code: "some code", credits: 42, description: "some description", name: "some name", term: "some term"}
  @update_attrs %{code: "some updated code", credits: 43, description: "some updated description", name: "some updated name", term: "some updated term"}
  @invalid_attrs %{code: nil, credits: nil, description: nil, name: nil, term: nil}

  def fixture(:course) do
    {:ok, course} = Courses.create_course(@create_attrs)
    course
  end

  describe "index" do
    test "lists all courses", %{conn: conn} do
      conn = get conn, course_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Courses"
    end
  end

  describe "new course" do
    test "renders form", %{conn: conn} do
      conn = get conn, course_path(conn, :new)
      assert html_response(conn, 200) =~ "New Course"
    end
  end

  describe "create course" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, course_path(conn, :create), course: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == course_path(conn, :show, id)

      conn = get conn, course_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Course"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, course_path(conn, :create), course: @invalid_attrs
      assert html_response(conn, 200) =~ "New Course"
    end
  end

  describe "edit course" do
    setup [:create_course]

    test "renders form for editing chosen course", %{conn: conn, course: course} do
      conn = get conn, course_path(conn, :edit, course)
      assert html_response(conn, 200) =~ "Edit Course"
    end
  end

  describe "update course" do
    setup [:create_course]

    test "redirects when data is valid", %{conn: conn, course: course} do
      conn = put conn, course_path(conn, :update, course), course: @update_attrs
      assert redirected_to(conn) == course_path(conn, :show, course)

      conn = get conn, course_path(conn, :show, course)
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, course: course} do
      conn = put conn, course_path(conn, :update, course), course: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Course"
    end
  end

  describe "delete course" do
    setup [:create_course]

    test "deletes chosen course", %{conn: conn, course: course} do
      conn = delete conn, course_path(conn, :delete, course)
      assert redirected_to(conn) == course_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, course_path(conn, :show, course)
      end
    end
  end

  defp create_course(_) do
    course = fixture(:course)
    {:ok, course: course}
  end
end
