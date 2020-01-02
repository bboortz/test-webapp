#!/bin/sh


HOST=0.0.0.0
PORT=4444

export FLASK_APP=status.py

if [ ! -f /.dockerenv ]; then
	source .venv/bin/activate
fi


python webserver.py
