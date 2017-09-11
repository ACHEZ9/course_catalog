defmodule CourseCatalogWeb.Router do
  use CourseCatalogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CourseCatalogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", CourseController, :search

    post "/courses/search", CourseController, :search, as: :course_search

    resources "/courses", CourseController
    resources "/subjects", SubjectController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CourseCatalogWeb do
  #   pipe_through :api
  # end
end
