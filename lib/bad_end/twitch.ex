defmodule BadEnd.Twitch do
  def get_start_time(id) do
    url = "https://api.twitch.tv/helix/videos?id=#{id}"

    {:ok, tw_resp} =
      HTTPoison.get(url, [
        {"Authorization", Application.get_env(:bad_end, :twitch)[:token]},
        {"Client-Id", Application.get_env(:bad_end, :twitch)[:client_id]}
      ])

    {:ok, date_time, _} =
      tw_resp.body
      |> Jason.decode!()
      |> Map.get("data")
      |> List.first()
      |> Map.get("created_at")
      |> DateTime.from_iso8601()

    date_time
  end
end
