defmodule SntxGraph.BlogMutations do
  use Absinthe.Schema.Notation

  alias SntxGraph.Middleware.Authorize
  alias SntxGraph.BlogResolver, as: Resolver

  object :blog_mutations do
    @desc "Create a blog with title and body for a logged in User"
    field :blog_create, :post do
      arg :title, non_null(:string)
      arg :body, :string

      middleware(Authorize)
      resolve(&Resolver.create/3)
    end

    field :blog_edit, :post do
      arg :id, non_null(:uuid4)
      arg :title, :string
      arg :body, :string

      middleware(Authorize)
      resolve(&Resolver.edit/3)
    end

    field :blog_delete, :post do
      arg :id, non_null(:uuid4)

      middleware(Authorize)
      resolve(&Resolver.delete/3)
    end
  end
end
