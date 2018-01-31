defmodule Drip.Subscriber do
  alias Drip.Client

  def add(%{} = subscriber, account_id) do
    body = construct_body(subscriber)
    Client.post(account_id <> "/subscribers", body)
  end

  defp construct_body(subscriber) do
    subscriber
    |> wrap_subscriber()
    |> stringify()
  end

  defp wrap_subscriber(subscriber) do
    %{subscribers: [subscriber]}
  end

  defp stringify(data) do
    data
    |> Poison.encode!()
  end
end
