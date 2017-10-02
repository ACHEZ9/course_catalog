defmodule CourseCatalog.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias CourseCatalog.Accounts.Session


  schema "account_sessions" do
    field :token, :string
    belongs_to :user, CourseCatalog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Session{} = session, attrs) do
    session
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end

  def registration_changeset(%Session{} = session, attrs) do
    session
    |> changeset(attrs)
    |> assoc_constraint(:user)
    |> put_change(:token, Phoenix.Token.sign(CourseCatalogWeb.Endpoint, "user auth", attrs[:user_id]))
  end
end
