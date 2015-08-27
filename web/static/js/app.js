import {Socket} from "deps/phoenix/web/static/js/phoenix"
import "deps/phoenix_html/web/static/js/phoenix_html"

let socket = new Socket("/cs")
socket.connect({token: $("meta[name=channel_token]").attr("content")})
let chan = socket.channel("carts:lobby", {})
chan.join().receive("ok", msg => {
    console.log("Success!", msg)
})

chan.on("add_to_cart", msg => {
    console.log(msg.count)
})

let App = {
}

export default App
