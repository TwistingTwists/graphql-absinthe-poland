defmodule SntxGraph.BlogTypes do
  use Absinthe.Schema.Notation

  # import AbsintheErrorPayload.Payload

  # alias Sntx.Uploaders
  # alias Sntx.User.Account

  # payload_object(:user_account_payload, :user_account)
  # payload_object(:user_session_payload, :user_session)

  # input_object :user_account_create_input do
  #   import_fields(:user_account_input)

  #   field :password, :string
  # end

  ## blog create payload.
  import AbsintheErrorPayload.Payload

  payload_object(:blog_post_create_payload, :post_create)

  object :post_create do
    field :title, :string
    field :body, :string
    # field :author_id, :uuid4
  end

  object :post do
    field :title, :string
    field :body, :string
    field :author, :user_account
  end
end
