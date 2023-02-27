defmodule SntxGraph.BlogResolver do
  import SntxWeb.Payload
  import SntxWeb.Gettext

  alias Sntx.Blog.Post

  def get(_parent, %{id: id}, _resolution) do
    {:ok, Post.get(id)}
  end

  def all(_parent, %{of_user: user_email}, _resolution) do
    {:ok, Post.get_by(%{of_user: user_email})}
  end

  def all(_parent, _args, _resolution) do
    {:ok, Post.list()}
  end


  def create(_parent, %{title: _title, body: _body} = attrs, %{context: %{user: user}}) do
    with {:ok, post} <- Post.create(user, attrs) do
      {:ok, post}
    else
      error -> mutation_error_payload(error)
    end
  end

  def create(_parent, _args, _resolution) do
    {:error, dgettext("global", "access_denied")}
  end

  def edit(_parent, %{id: post_id} = attrs, %{context: %{user: user}}) do
    with {:ok, post} <- Post.get(post_id),
         true <- post.author.id == user.id,
         {:ok, updated_post} <- Post.update(post, attrs) do
      {:ok, updated_post}
    else
      error -> mutation_error_payload(error)
    end
  end

  def edit(_parent, _args, _resolution) do
    {:error, dgettext("global", "access_denied")}
  end


  def delete(_parent, %{id: post_id} = _attrs, %{context: %{user: user}}) do
    with  {:ok, post} <- Post.get(post_id),
    true <- post.author.id == user.id,
    {:ok, post} <- Post.delete(post) do
      {:ok, post}
    else
      error -> mutation_error_payload(error)
    end
  end

  def delete(_parent, _args, _resolution) do
    {:error, dgettext("global", "access_denied")}
  end
end
