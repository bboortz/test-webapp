# test-webapp
Simple Webapp for verifying HTTP(S) Requests


# Overview

test-webapp is a simple web application written in python in order to verify HTTP(S) requests and responses. This tool is useful fo tracing web requests.

## This project will be build and tested using github actions
https://github.com/bboortz/test-webapp/workflows/Test%20Python%20Application/badge.svg
https://github.com/bboortz/test-webapp/workflows/Build%20Docker%20Image/badge.svg
https://github.com/bboortz/test-webapp/workflows/Deploy%20to%20GKE/badge.svg


# Goals

* providing web application which can be used for testing / tracing purposes
* inspecting http(s) requests
* inspecting http(s) responses
* simulating issues like latency


# Current Features

* simple usage
* simple test cases
* http listener


# Requirements

* python 3.X (the runtime)
* make (for building this)
* docker (to run it inside a k8s cluster)


# Installation

```
make install
```


# Usage

```
make run
```

OR

```
python webserver.py
```
