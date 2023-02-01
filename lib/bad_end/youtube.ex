defmodule BadEnd.Youtube do
  def get_start_time(id) do
    url =
      "https://youtube.googleapis.com/youtube/v3/videos?part=liveStreamingDetails&id=#{id}&access_token=#{Application.get_env(:bad_end, :youtube)[:token]}"

    {:ok, yt_resp} = HTTPoison.get(url)

    {:ok, date_time, _} =
      yt_resp.body
      |> Jason.decode!()
      |> Map.get("items")
      |> List.first()
      |> Map.get("liveStreamingDetails")
      |> Map.get("actualStartTime")
      |> DateTime.from_iso8601()

    date_time
  end
end
