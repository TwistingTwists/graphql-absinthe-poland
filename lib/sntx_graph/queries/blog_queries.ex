defmodule SntxGraph.BlogQueries do
  use Absinthe.Schema.Notation

  alias SntxGraph.BlogResolver, as: Resolver

  object :blog_queries do
    @desc "Listing all blog posts"
    field :posts, list_of(:post) do
      arg :of_user, :string
      resolve(&Resolver.all/3)
    end

    @desc "get a single blog post "
    field :post, :post do
      arg :id, non_null(:uuid4)
      resolve(&Resolver.get/3)
    end
  end
end
