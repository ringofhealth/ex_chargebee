defmodule ExChargebee.PaymentIntent do
  @moduledoc """
  an interface for interacting with PaymentIntents
  """
  use ExChargebee.Resource,
    stdops: [
      :create,
      :update,
      :retrieve
    ]
end
