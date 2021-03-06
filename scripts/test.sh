#!/bin/bash


set -e
set -u


#
# confg
#
URL="${1:-http://localhost:4444}"
CURL="curl --fail --silent -o /dev/null -w %{http_code}"
ERRORS=0



#
# method
#
do_curl() {
	local option="${1}"
	local url="${2}"
	local content_type="${3}"
	local expected_code="${4}"

	curl_cmd="$CURL -X ${option} ${url}"

	local http_code
	set -x
	http_code=$( ${curl_cmd} -H "Content-Type: ${content_type}" )
	set +x
	echo "  http_code: ${http_code}"
	if [ "${http_code}" != "${expected_code}" ]; then
		let ERRORS=$ERRORS+1
		echo "  ERROR!"
		echo "    http_code: ${http_code} != ${expected_code}"
	else
		echo "  SUCCESS!"
	fi
}



if [ "${URL}" == "http://localhost:4444" ]; then
	#
	# prepare
	#
	source .venv/bin/activate

	pip install -U -r requirements-test.txt


	#
	# pytest
	#
	# echo -e "\nRUNNINGPYTEST UNIT TESTS"
	# pytest


	# flake8
	echo -e "\nRUNNING FLAKE8 TESTS"
	flake8 . --exclude=.venv,OLD --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 . --exclude=.venv,OLD --count --max-complexity=10 --max-line-length=127 --statistics

fi


#
# running application in dev mode
#
echo -e "\nRUNNING THE APPLICATION"
timeout 10 ./scripts/run.sh > testrun.log 2>&1 &



#
# test run
#
echo -e "\nSIMULATING TESTS"
sleep 1
do_curl "GET"    "${URL}"              "text/html"        "200"
do_curl "GET"    "${URL}/"             "text/html"        "200"
do_curl "GET"    "${URL}/test"         "text/html"        "200"
do_curl "GET"    "${URL}/api/TEST"     "text/html"        "200"
do_curl "GET"    "${URL}/api/1234"     "text/html"        "200"
