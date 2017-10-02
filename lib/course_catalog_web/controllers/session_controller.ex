defmodule CourseCatalogWeb.SessionController do
  use CourseCatalogWeb, :controller

  alias CourseCatalog.Accounts

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Accounts.create_session(username, password) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Successully Logged In")
        |> redirect(to: course_path(conn, :search))
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid usernam/password combination")
        |> render("new.html")
    end
  end
end
