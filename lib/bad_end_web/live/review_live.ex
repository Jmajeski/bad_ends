defmodule BadEndWeb.ReviewLive do
  use BadEndWeb, :live_view

  alias BadEnd.Twitch
  alias BadEnd.WarcraftLogs
  alias BadEnd.Youtube

  def render(assigns) do
    ~H"""
    <img src="/images/guardian.png" alt="goated guardian"/>

    <div class="main">
      <form phx-submit="lookup">
        <input type="text" name="log_url" placeholder="Enter log link"/>
        <input type="text" name="vod_url" placeholder="Enter vod link"/>
        <input type="submit"/>
      </form>

      <%= if !Enum.empty?(@fights) do %>
        <%= if @platform == :youtube do %>
          <%= render(BadEndWeb.PlayerView, "youtube.html", vod_id: @vod_id) %>
        <% else %>
          <%= render(BadEndWeb.PlayerView, "twitch.html", vod_id: @vod_id) %>
        <% end %>

        <div class="fightList">
          <%= for fight <- @fights do %>
            <div class="fight">
              <button class={if fight.kill do "buttonKill" else "button" end} phx-click="select_fight" phx-value-start={fight.start_time}><%= fight.kill %> <%= fight.start_time %> </button>
              <div class="percentBar" style={"width:#{fight.percent}%;background:#{fight.fight_color};display:#{percent_bar_hide(fight.kill)}"}></div>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    <div><%= @offset %></div>

    <script src="https://player.twitch.tv/js/embed/v1.js"></script>
    <script src="https://www.youtube.com/iframe_api"></script>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:fights, [])
      |> assign(:offset, 0)
      |> assign(:platform, :youtube)

    {:ok, socket}
  end

  def handle_event("lookup", %{"log_url" => "", "vod_url" => ""}, socket) do
    fights = BadEnd.FakeData.fake_fights()

    {platform, start_time, vod_id} = BadEnd.FakeData.fake_vid_info()

    socket =
      socket
      |> assign(:vod_id, vod_id)
      |> assign(:fights, fights)
      |> assign(:platform, platform)
      |> assign(:start_time, start_time)

    {:noreply, socket}
  end

  def handle_event("lookup", %{"log_url" => log_url, "vod_url" => vod_url}, socket) do
    fights = WarcraftLogs.get_pulls_from_report(log_url)

    {platform, start_time, vod_id} = get_vod_info(vod_url)

    IO.inspect({platform, start_time, vod_id})

    socket =
      socket
      |> assign(:vod_id, vod_id)
      |> assign(:fights, fights)
      |> assign(:platform, platform)
      |> assign(:start_time, start_time)

    {:noreply, socket}
  end

  def handle_event("select_fight", %{"start" => start}, socket) do
    vod_start_time = socket.assigns.start_time

    {:ok, date_time, _} = DateTime.from_iso8601(start)

    offset = DateTime.diff(date_time, vod_start_time)

    offset2 = socket.assigns.offset

    {:noreply, push_event(socket, "setTime", %{time: offset + offset2})}
  end

  def handle_event("update_offset", %{"_target" => ["offset"], "offset" => offset}, socket) do
    {:noreply, assign(socket, :offset, offset)}
  end

  defp get_vod_info("https://www.youtube.com/watch?v=" <> id),
    do: {:youtube, Youtube.get_start_time(id), id}

  defp get_vod_info("https://www.twitch.tv/videos/" <> id),
    do: {:twitch, Twitch.get_start_time(id), id}

  def percent_bar_hide(kill) do
    if kill do
      "none"
    else
      "block"
    end
  end
end
