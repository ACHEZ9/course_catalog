defmodule CourseCatalog.Repo.Migrations.CreateAccountSessions do
  use Ecto.Migration

  def change do
    create table(:account_sessions) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:account_sessions, [:token])
    create index(:account_sessions, [:user_id])
  end
end
