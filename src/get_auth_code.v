module main

import net.http
import strconv
import json

struct CodeResponse {
mut:
	result_code int
	data        string
	message     string
}

fn get_auth_code() !string {
	data := json.encode({
		'clientType': 'web'
	})

	mut headers := http.new_header()
	headers.add(.user_agent, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:139.0) Gecko/20100101 Firefox/139.0')
	headers.add(.accept, 'application/json, text/plain, */*')
	headers.add_custom('Accept-Language', 'en-US,en;q=0.5')!
	headers.add_custom('Accept-Encoding', 'identity')!
	headers.add_custom('Referer', 'https://push.boox.com/')!
	headers.add_custom('Origin', 'https://push.boox.com')!
	headers.add_custom('Sec-Fetch-Dest', 'empty')!
	headers.add_custom('Sec-Fetch-Mode', 'no-cors')!
	headers.add_custom('Sec-Fetch-Site', 'same-origin')!
	headers.add_custom('Priority', 'u=0')!
	headers.add_custom('Pragma', 'no-cache')!
	headers.add_custom('Cache-Control', 'no-cache')!
	headers.add(.content_type, 'application/json')

	resp := http.fetch(http.FetchConfig{
		url:    'https://push.boox.com/api/1/auth/qrcode/create'
		method: .post
		header: headers
		data:   data
	})!
	if resp.status_code != 200 {
		status_code_str := unsafe { strconv.v_sprintf('%s', resp.status_code) }
		bad_resp := unsafe { strconv.v_sprintf('%s', resp) }
		panic('Failed to get auth code. Instead, got HTTP status code ' + status_code_str +
			' with contents: ' + bad_resp)
	}

	resp_data := json.decode(CodeResponse, resp.body)!
	if resp_data.result_code != 0 {
		bad_resp := unsafe { strconv.v_sprintf('%s', resp) }
		panic('Failed to get auth code. Instead, got: ' + bad_resp)
	}

	return resp_data.data
}
