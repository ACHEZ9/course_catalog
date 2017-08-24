defmodule CourseCatalogWeb.SubjectControllerTest do
  use CourseCatalogWeb.ConnCase

  alias CourseCatalog.Courses

  @create_attrs %{abbreviation: "some abbreviation", name: "some name", term: "some term"}
  @update_attrs %{abbreviation: "some updated abbreviation", name: "some updated name", term: "some updated term"}
  @invalid_attrs %{abbreviation: nil, name: nil, term: nil}

  def fixture(:subject) do
    {:ok, subject} = Courses.create_subject(@create_attrs)
    subject
  end

  describe "index" do
    test "lists all subjects", %{conn: conn} do
      conn = get conn, subject_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Subjects"
    end
  end

  describe "new subject" do
    test "renders form", %{conn: conn} do
      conn = get conn, subject_path(conn, :new)
      assert html_response(conn, 200) =~ "New Subject"
    end
  end

  describe "create subject" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, subject_path(conn, :create), subject: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == subject_path(conn, :show, id)

      conn = get conn, subject_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Subject"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, subject_path(conn, :create), subject: @invalid_attrs
      assert html_response(conn, 200) =~ "New Subject"
    end
  end

  describe "edit subject" do
    setup [:create_subject]

    test "renders form for editing chosen subject", %{conn: conn, subject: subject} do
      conn = get conn, subject_path(conn, :edit, subject)
      assert html_response(conn, 200) =~ "Edit Subject"
    end
  end

  describe "update subject" do
    setup [:create_subject]

    test "redirects when data is valid", %{conn: conn, subject: subject} do
      conn = put conn, subject_path(conn, :update, subject), subject: @update_attrs
      assert redirected_to(conn) == subject_path(conn, :show, subject)

      conn = get conn, subject_path(conn, :show, subject)
      assert html_response(conn, 200) =~ "some updated abbreviation"
    end

    test "renders errors when data is invalid", %{conn: conn, subject: subject} do
      conn = put conn, subject_path(conn, :update, subject), subject: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Subject"
    end
  end

  describe "delete subject" do
    setup [:create_subject]

    test "deletes chosen subject", %{conn: conn, subject: subject} do
      conn = delete conn, subject_path(conn, :delete, subject)
      assert redirected_to(conn) == subject_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, subject_path(conn, :show, subject)
      end
    end
  end

  defp create_subject(_) do
    subject = fixture(:subject)
    {:ok, subject: subject}
  end
end
