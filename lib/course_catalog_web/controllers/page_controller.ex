defmodule CourseCatalogWeb.PageController do
  use CourseCatalogWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
