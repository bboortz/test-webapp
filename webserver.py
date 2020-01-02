
#
# Imports
#

import os
import threading
import time
import uuid
from http.server import HTTPServer, BaseHTTPRequestHandler
from socketserver import ThreadingMixIn


#
# Global Variables
#

USE_HTTPS = False
HTTP_CODE = 200
SLEEP = 0


#
# Classes
#

class Handler(BaseHTTPRequestHandler):

    def __init__(self, *args, directory=None, **kwargs):
        self.server_version = "test-webapp"
        self.sys_version = "python"
        if directory is None:
            directory = os.getcwd()
        self.directory = directory
        super().__init__(*args, **kwargs)

    def do_GET(self):
        time.sleep(SLEEP)
        self.send_response(HTTP_CODE)
        self.send_header("Content-type", "text/html")
        self.send_header("X-Request-Id", uuid.uuid4())
        self.end_headers()

        resp = b"<html><head><title>test webapp</title></head>"
        resp += b"<body><h2>test-webapp</h2>"

        resp += b"<h3>Server Stats</h3>"
        resp += b"<p>CurrentThread: %s" % threading.currentThread().getName().encode()
        resp += b"<p>ActiveThreads: %s" % str(threading.active_count()).encode()

        resp += b"<h3>Request</h3>"
        resp += b"<p>RequestLine: %s</p>" % self.requestline.encode()
        resp += b"<p>Method: %s</p>" % self.command.encode()
        resp += b"<p>RequestVersion: %s</p>" % self.request_version.encode()
        resp += b"<p>Path: %s</p>" % self.path.encode()
        resp += b"<p>ClientAddress: %s</p>" % self.client_address[0].encode()

        resp += b"<h4>Request Headers</h4>"
        for h in self.headers:
            resp += b"<p>%s: %s</p>" % (h.encode(), self.headers[h].encode())

        resp += b"<h3>Response</h3>"
        resp += b"<p>HttpCode: %s</p>" % str(HTTP_CODE).encode()
        resp += b"</body></html>"
        self.wfile.write(resp)


class ThreadingSimpleServer(ThreadingMixIn, HTTPServer):
    pass


#
# Methods
#

def run(port=4444):
    server = ThreadingSimpleServer(('0.0.0.0', port), (Handler))
    if USE_HTTPS:
        import ssl
        server.socket = ssl.wrap_socket(server.socket, keyfile='./key.pem', certfile='./cert.pem', server_side=True)
    server.serve_forever()


#
# Program
#

if __name__ == '__main__':
    run()
