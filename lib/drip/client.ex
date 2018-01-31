defmodule Drip.Client do
  @baseURL "https://api.getdrip.com/v2/"
  @content_type "application/vnd.api+json"

  def post(path, body) do
    execute(:post, path, body)
  end

  defp execute(method, path, body, header_options \\ []) do
    Task.Supervisor.start_child(Drip.TaskSupervisor, fn ->
      HTTPoison.request!(method, uri(path), body, headers(header_options))
    end)
    
  end

  defp uri(path), do: @baseURL <> path

  defp api_key do
    Application.get_env(:drip, :api_key)
    |> Base.encode64()
  end

  defp headers(options) do
    [
      "User-Agent": "Drip (Elixir)",
      Authorization: "Basic #{api_key()}",
      "Content-Type": @content_type
    ]
    |> Keyword.merge(options)
  end
end
