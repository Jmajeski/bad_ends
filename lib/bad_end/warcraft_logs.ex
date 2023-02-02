defmodule BadEnd.WarcraftLogs do
  def get_pulls_from_report("https://www.warcraftlogs.com/reports/" <> report_id) do
    Neuron.Config.set(url: "https://www.warcraftlogs.com/api/v2/client")

    Neuron.Config.set(
      headers: [authorization: Application.get_env(:bad_end, :warcraft_logs)[:token]]
    )

    {:ok, %{body: %{"data" => %{"reportData" => %{"report" => report}}}}} =
      Neuron.query("""
      {
        reportData {
          report(code: \"#{report_id}\") {
            startTime
            fights(killType: Encounters) {
              kill
              startTime
              fightPercentage
            }
          }
        }
      }
      """)

    report_start_time = report["startTime"]

    Enum.map(report["fights"], fn fight ->
      unix_start = report_start_time + fight["startTime"]
      start_time = DateTime.from_unix!(unix_start, :millisecond)
      percent = trunc(fight["fightPercentage"])
      boss = Enum.random(0..3)

      %{
        kill: fight["kill"],
        start_time: start_time,
        percent: percent,
        fight_color: percent_to_color(percent),
        boss: boss
      }
    end)
  end

  def percent_to_color(percent) when percent in 0..24 do
    "#ccc"
  end

  def percent_to_color(percent) when percent in 25..49 do
    "#0f8000"
  end

  def percent_to_color(percent) when percent in 50..74 do
    "#0070ff"
  end

  def percent_to_color(percent) when percent in 75..94 do
    "#a335ee"
  end

  def percent_to_color(percent) when percent in 95..98 do
    "#ff8000"
  end

  def percent_to_color(percent) when percent in 98..100 do
    "#e268a8"
  end
end
