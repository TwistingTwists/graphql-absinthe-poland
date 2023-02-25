defmodule Sntx.Blog.Post do
  use Sntx.Schema

  import Ecto.Changeset

  alias Sntx.User.Account, as: UserAccount

  schema "blog_posts" do
    field :body, :string
    field :title, :string
    # field :author_id, :binary_id
    belongs_to :author, UserAccount

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
