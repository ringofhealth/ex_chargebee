defmodule ExChargebee.InvoiceTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  def subject do
    ExChargebee.Invoice.close(
      "draft_inv_abcde",
      %{
        "invoice_note" => "This is a note"
      }
    )
  end

  describe "close" do
    test "incorrect auth" do
      expect(
        ExChargebee.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/draft_inv_abcde/close"

          assert data == "invoice_note=This+is+a+note"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 401
          }
        end
      )

      assert_raise ExChargebee.UnauthorizedError, fn ->
        subject()
      end
    end

    test "not found" do
      expect(
        ExChargebee.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/draft_inv_abcde/close"

          assert data == "invoice_note=This+is+a+note"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 404
          }
        end
      )

      assert_raise ExChargebee.NotFoundError, fn ->
        subject()
      end
    end

    test "incorrect data" do
      expect(
        ExChargebee.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/draft_inv_abcde/close"

          assert data == "invoice_note=This+is+a+note"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 400,
            body: '{"message": "Unknown"}'
          }
        end
      )

      assert_raise ExChargebee.InvalidRequestError, fn ->
        subject()
      end
    end

    test "correct data" do
      expect(
        ExChargebee.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/draft_inv_abcde/close"

          assert data == "invoice_note=This+is+a+note"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 200,
            body: '{"invoice": {"id": "abcde"}}'
          }
        end
      )

      assert subject() == %{"id" => "abcde"}
    end
  end
end