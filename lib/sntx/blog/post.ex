defmodule Sntx.Blog.Post do
  use Sntx.Schema

  import Ecto.Changeset
  import Ecto.Query
  import SntxWeb.Gettext

  alias Sntx.User.Account, as: UserAccount
  alias Sntx.Repo
  alias __MODULE__

  schema "blog_posts" do
    field :body, :string
    field :title, :string
    # field :author_id, :binary_id
    belongs_to :author, UserAccount, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(post \\ %Post{}, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end

  def list(), do: Repo.all(Post)

  def create(user, attrs) do
    attrs
    |> changeset()
    |> put_assoc(:author, user)
    |> Repo.insert()
  end

  def get(id) do
    Repo.get(Post, id) |> Repo.preload(:author)
  end

  def get_by(%{of_user: user_email}) do
    query = from p in Post, join: u in UserAccount, on: u.id == p.author_id, where: u.email == ^user_email

    Repo.all(query)
  end

  def update(post, attrs) do
    changeset(post, attrs)
    |> Repo.update()
  end

  def delete(post) do
    Repo.delete(post)
  end
end
