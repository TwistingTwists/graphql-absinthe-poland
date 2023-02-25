defmodule Sntx.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :string
      add :author_id, references(:user_accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:blog_posts, [:author_id])
  end
end
