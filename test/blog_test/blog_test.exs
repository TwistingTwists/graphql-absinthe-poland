defmodule SntxGraph.BlogTest do
  use SntxWeb.ConnCase

  alias Sntx.User.Account
  alias Sntx.Blog.Post

  def setup_users() do
    attrs = %{
      email: "a1@b.com",
      password: "abcd1234",
      role: :user,
      first_name: "1_user_last_name",
      last_name: "1_user_last_name"
    }

    {:ok, user1} = Account.create(attrs)

    attrs = %{
      email: "a2@b.com",
      password: "abcd1234",
      role: :user,
      first_name: "2_user_last_name",
      last_name: "2_user_last_name"
    }

    {:ok, user2} = Account.create(attrs)

    [user1, user2]
  end

  def setup_blogs(users) do
    Enum.each(users, fn user ->
      attrs = %{
        body: "body - #{user.email}",
        title: "#{user.first_name}"
      }

      Post.create(user, attrs)
    end)
  end

  test "query: list posts", %{conn: conn} do
    user_query = """
      {
        posts {
          body
          title
        }
      }
    """

    users = setup_users()
    setup_blogs(users)

    conn =
      post(conn, "/graphql", %{
        "query" => user_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "posts" => [
                 %{"body" => "body - a1@b.com", "title" => "1_user_last_name"},
                 %{"body" => "body - a2@b.com", "title" => "2_user_last_name"}
               ]
             }
           }
  end
end
