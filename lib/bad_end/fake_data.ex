defmodule BadEnd.FakeData do
  def fake_vid_info do
    {:youtube, ~U[2022-04-20 00:01:53Z], "qNFpgvxKOK0"}
  end

  def fake_fights do
    [
      %{
        boss: 1,
        fight_color: "#0f8000",
        kill: false,
        percent: 48,
        start_time: ~U[2022-04-20 00:05:48.380Z]
      },
      %{
        boss: 2,
        fight_color: "#0f8000",
        kill: false,
        percent: 42,
        start_time: ~U[2022-04-20 00:11:23.211Z]
      },
      %{
        boss: 2,
        fight_color: "#ccc",
        kill: true,
        percent: 0,
        start_time: ~U[2022-04-20 00:16:59.872Z]
      },
      %{
        boss: 1,
        fight_color: "#ccc",
        kill: true,
        percent: 0,
        start_time: ~U[2022-04-20 00:33:24.381Z]
      },
      %{
        boss: 0,
        fight_color: "#0f8000",
        kill: false,
        percent: 34,
        start_time: ~U[2022-04-20 00:46:40.786Z]
      },
      %{
        boss: 2,
        fight_color: "#0f8000",
        kill: false,
        percent: 27,
        start_time: ~U[2022-04-20 00:58:32.230Z]
      },
      %{
        boss: 3,
        fight_color: "#0070ff",
        kill: false,
        percent: 50,
        start_time: ~U[2022-04-20 01:05:29.354Z]
      },
      %{
        boss: 1,
        fight_color: "#0070ff",
        kill: false,
        percent: 63,
        start_time: ~U[2022-04-20 01:11:00.731Z]
      },
      %{
        boss: 1,
        fight_color: "#ccc",
        kill: false,
        percent: 14,
        start_time: ~U[2022-04-20 01:15:36.799Z]
      },
      %{
        boss: 3,
        fight_color: "#0070ff",
        kill: false,
        percent: 63,
        start_time: ~U[2022-04-20 01:23:42.086Z]
      },
      %{
        boss: 0,
        fight_color: "#0070ff",
        kill: false,
        percent: 64,
        start_time: ~U[2022-04-20 01:27:31.379Z]
      },
      %{
        boss: 3,
        fight_color: "#0070ff",
        kill: false,
        percent: 60,
        start_time: ~U[2022-04-20 01:43:23.773Z]
      },
      %{
        boss: 0,
        fight_color: "#0070ff",
        kill: false,
        percent: 50,
        start_time: ~U[2022-04-20 01:47:56.759Z]
      },
      %{
        boss: 3,
        fight_color: "#0f8000",
        kill: false,
        percent: 40,
        start_time: ~U[2022-04-20 01:54:19.603Z]
      },
      %{
        boss: 1,
        fight_color: "#ccc",
        kill: false,
        percent: 14,
        start_time: ~U[2022-04-20 02:00:24.016Z]
      },
      %{
        boss: 1,
        fight_color: "#ccc",
        kill: true,
        percent: 0,
        start_time: ~U[2022-04-20 02:08:19.665Z]
      },
      %{
        boss: 3,
        fight_color: "#ccc",
        kill: false,
        percent: 22,
        start_time: ~U[2022-04-20 02:30:42.655Z]
      },
      %{
        boss: 3,
        fight_color: "#a335ee",
        kill: false,
        percent: 86,
        start_time: ~U[2022-04-20 02:38:22.677Z]
      },
      %{
        boss: 0,
        fight_color: "#ccc",
        kill: false,
        percent: 20,
        start_time: ~U[2022-04-20 02:40:06.744Z]
      },
      %{
        boss: 0,
        fight_color: "#ccc",
        kill: true,
        percent: 0,
        start_time: ~U[2022-04-20 02:46:20.973Z]
      }
    ]
  end
end
