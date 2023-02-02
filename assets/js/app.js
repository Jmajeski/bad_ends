// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}
Hooks.YTPlayer = {
    mounted() {
        
        console.log("mounted yt")

        var youtube_player;

        console.log("on ready")
        youtube_player = new YT.Player('yt_player', {
            height: '1080',
            width: '1920',
            videoId: this.el.dataset.vodId,
            playerVars: {
                'playsinline': 1
            },
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });

        function onPlayerReady(event) {
            youtube_player.setSize(1280, 720)
            console.log("player ready")
        }

        function onPlayerStateChange(event) {
            console.log("player state change")
        }

        this.handleEvent("setTime", ({ time }) => {
            console.log(time)
            youtube_player.seekTo(time)
        })
    },
    updated() {
        console.log("updated yt")
    }
}

Hooks.TWPlayer = {
    mounted() {
        console.log("mounted tw")

        var options = {
            width: 1920,
            height: 1080,
            video: this.el.dataset.vodId
        };
        var twitch_player = new Twitch.Player("twitch_player", options);

        this.handleEvent("setTime", ({ time }) => {
            twitch_player.seek(time)
            console.log(time)
        })
    },
    updated() {
        console.log("updated tw")
    }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

