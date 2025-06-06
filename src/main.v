module main

// import net.http
// import strconv
// import json
import qr

fn main() {
	auth_url := get_auth_code()!
	println(auth_url)

	println(qr.text(auth_url))

	auth_code := auth_url.split('---')[0]

	token := try_auth_code(auth_code)!
	println(token)
}
