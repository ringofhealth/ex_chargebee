defmodule ExChargebee.Invoice do
  @moduledoc """
  an interface for interacting with Invoices
  """
  use ExChargebee.Resource

  def close(id, params \\ %{}) do
    post_resource(id, "/close", params)
  end
end
