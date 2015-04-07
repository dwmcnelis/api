# spec/support/api_helpers.rb

def auth_header(user)
	{'Authorization' => "Bearer #{user ? user.generate_token : 'xxxxxx'}"}
end

def accept_header(mime_type)
	{'Accept' => mime_type}
end

def content_type_header(mime_type)
	{'Content-Type' => mime_type}
end

def content_length_header(length)
	{'Content-Length' => length}
end

def merge_headers(*header)
	header.inject(&:merge)
end

def http_status(code)
	{
		#	1xx Informational
		continue: 100,
		switching_protocols: 101,
		processing: 102,
		#	2xx Success
		ok: 200,
		created: 201,
		accepted: 202,
		non_authoritative_information: 203,
		no_content: 204,
		reset_content: 205,
		partial_content: 206,
		multi_status: 207,
		im_used: 226,
		# 3xx Redirection
		multiple_choices: 300,
		moved_permanently: 301,
		found: 302,
		see_other: 303,
		not_modified: 304,
		use_proxy: 305,
		temporary_redirect: 307, 
		# 4xx Client Error
		bad_request: 400,
		unauthorized: 401,
		payment_required: 402,
		forbidden: 403,
		not_found: 404,
		method_not_allowed: 405,
		not_acceptable: 406,
		proxy_authentication_required: 407,
		request_timeout: 408,
		conflict: 409,
		gone: 410,
		length_required: 411,
		precondition_failed: 412,
		request_entity_too_large: 413,
		request_uri_too_long: 414,
		unsupported_media_type: 415,
		requested_range_not_satisfiable: 416,
		expectation_failed: 417,
		unprocessable_entity: 422,
		locked: 423,
		failed_dependency: 424,
		upgrade_required: 426,
		# 5xx Server Error
		internal_server_error: 500,
		not_implemented: 501,
		bad_gateway: 502,
		service_unavailable: 503,
		gateway_timeout: 504,
		http_version_not_supported: 505,
		insufficient_storage: 507,
		not_extended: 510
	}[code]
end

def attachment_body(boundary, upload, filename, for_type, for_id, for_attribute)
	"--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[upload]\"\r\n\r\n#{upload}\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[content]\"; filename=\"#{filename}\"\r\nContent-Type: image/png\r\n\r\n\x89PNG\r\n\u001A\n\u0000\u0000\u0000\rIHDR\u0000\u0000\u0000\xE1\u0000\u0000\u0000\xE1\b\u0003\u0000\u0000\u0000\tm\"H\u0000\u0000\u0000WPLTE\xFF\xFF\xFF\x80\x80\x80zzzwww\xE9\xE9\xE9\xC5\xC5\xC5\xD4\xD4Ԑ\x90\x90|||\xFA\xFA\xFA\x81\x81\x81\xE2\xE2\xE2\xC9\xC9ɮ\xAE\xAE\xBB\xBB\xBB\xDA\xDA\xDA\xED\xED틋\x8B\x98\x98\x98rrr\xF3\xF3\xF3\xCF\xCFϩ\xA9\xA9\xA2\xA2\xA2\xB7\xB7\xB7\x8D\x8D\x8D\x9C\x9C\x9C\xC0\xC0\xC0\xB1\xB1\xB1xaf\xD7\u0000\u0000\u0003\x83IDATx\x9C\xED\xDD\xEBr\xAA0\u0014@\xE1\u0004\xACF\xD4\xE2\u0005\xB1\xB6}\xFF\xE7<\xF6ϙ\u0011CK ;;\xE8Z/\u0010\xBF\t*\x91 \xC6\u0010\u0011\u0011\u0011\xBDH\xEBEҒ\xFB\x96\xD7S\x99\xB6]\x93\u0014ؖ6u\xAE\xDA<7\xF0\xA7t\xC4Z\ah\x8Bd\xEFƣ\xD3\u0011Z\xB7O\u0003l*%\xA0\xB5U\u001A\xE2B\xE9 \xB5?\u001F7I\x88\x8A\u009B1ŗ\x86\xAA\xD0\u001E\u0012\u0010u\x85\xEE*O\xD4\u0015ZwX?\xB90\u0001Q[h\xDDJ\x98\xD8\u0011\xBAB0\xFF\xB9\x85;\xCA\u0012\xDD\nv\xE9!\xAE\u0012\n\x8B\xAD\xE4X\xEF='\x88\xB2\xB3\xD8\u0011\xBE\t\u000E\xD5+\xB4\xC5Ep\xD4,\x84\xA2\xC4<\x84\xB6\xF8\u0014\e5\u0013\xA1\xE0,\xAA\b\xAB\x83\x87\xB8\u0013\u001AUG\xD8\xF8fQ\x88\xA8#4\xFB\xEA\xF1\x88-e\x88J\xC2\e\xF1q\u0016\xCBo\x89Q\xB5\x84f_x\x88\xEF\u0002\xA3\xAA\t\xCD\xC2\xF3\xC9*A\xD4\u0013\x9AͣЖ_\xD1GU\u0014\x9A\x8Do\u0016\xA3\u00135\x85\xA6>y\x88\xE7ȣ\xAA\nM\xED\xFB\xB8\x89\xBC\xBE\xD1\u0015\xFA\x89qgQYhΞ_Q\xE2\xAER\xB5\x85\u001Ebe\x8B:\xE2\xA8\xEABs\xF6\u001D\xA8\u0011\x89\xFAB\xF3\xE5;P\xE3\u00113\u0010\x9Aw\u000F\xD1E#\xE6 \xF4\u0013c]$\xCEBh>|\aj$b\u001EB\xF3\xED\xFB\xE9=\u000E1\u0013\xA1ى\u0011s\u0011\x9A\xD6\xF3\xA5ac\\$\xCEFh.\u001Eb\x8C\xEB\xE0\xF9\b\xA5\x88\u0019\tͧ\b1'\xA19>\u0012\xDD\xE4K\xFDY\tמ\xEDK\x93\xAF\xBDe%\xBC\xCD\xE2\xE3q:uE\xAC#\xAC\xFBZz~\xBA\x998\x89:Wf\x8A\xBE\x8D\xA7\xBE/E;흘˵\xA7_*\xA7\xEDbD\u00183\x84\bǅ0f\xCF/\xFC\u0018z[\x87\x9B\xAB\xB0\u0019xK\xCD\xFE~\xB2g$\u001Cܶxv\xE1\e\u0090\u0010\xAA\x840(\x84*!\f\n\xA1J\b\x83B\xA8\u0012 \u0010\xAA\x840(\x84*!\f\n\xA1J\b\x83\xFA]\xB8_\xA6\xA9\xB3\xA5$\xA1\xF0\xED$yo\xF7\xFFN\xDDa\xD3\t\xB7\xDE\xEB\xEA\xD1\xEBn]G\x88\u0010!B\x84\b\u0011\"D\u0018&L\xF3\u001FK\xDDM\xB2\t\x85\xE7\xC3*E\x87\xCE]\xA3\xAC\u000F\x83B\xA8\u0012 \u0010\xAA\x840(\x84*\xCD\xF7\x9C\xE6:\xF0/\xCB\xE6{^:\xF4>\xB4\u0019\xAF-\u0010\"D\x88\u0010!B\x84\b\u0011J\b#_\xC7/\xAF\xD9\tc\xEF\xC5\u0018\xF8\xF7V\xAC\u000F\x83B\xA8\u0012 \u0010\xAA\x840\xA8W\u00176\e\xD12\u0010nEw_\xBA\xBE\x87\xAF\xCC\xF8\xCC\xFB\xBE\n!B\x84\b\u0011\"D\x88\u0010!\xC2aBWI\x96\x81ЬE\xEB{Q\xAC\x80\x83B\xA8\u0012 \u0010\xAA\x840\xA8W\u0017ֻ\xEFQ\xED\xA6=\xD1 \xE9\xEEK7\xAAr\xDA\xF3Sfp\xE6\xED\xA6\xBD(\x84A!D\x88pT\b\x83B\x88\u0010\xE1\xA88/\rꏵE\xBB\e\xD7l\xD6\u0016J!\f\n\xA1J\b\x83B\xA8\u0012 \u0010\xAA\x840(\x84*!\f\n\xA1J\b\x83B\xA8\x92\xA4p\xE2S\xBE#%\xF8\x84G\xD7ns\xA8\x95{J\xA7u\x92w\u0001\rN\xF0I\xABY\x86\u0010!B\xFD\u0010\xBE\xBC\xB0\xA9\xB4\u0001\u007FV5\x93\x84\xE68\xEE\x91\xEE\xE9r\xC7i@S\xE7~\x98\x96\u0003\xFF\xF2\xA5\xBF6ob\xD9N\u0005fN\x8C\u00014fy=\x95yv\xBA.c\u0000o\xAD\u0017y\xD6{\xDF\u0010\u0011\u0011\u0011ѳ\xF5\u000Fu(\x8F\xF8Z\u001De;\u0000\u0000\u0000\u0000IEND\xAEB`\x82\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[name]\"\r\n\r\nfile.png\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[mime_type]\"\r\n\r\nimage/png\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[size]\"\r\n\r\n1055\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[for_type]\"\r\n\r\n#{for_type}\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[for_id]\"\r\n\r\n#{for_id}\r\n--#{boundary}\r\nContent-Disposition: form-data; name=\"attachment[for_attribute]\"\r\n\r\n#{for_attribute}\r\n--#{boundary}--\r\n"
end