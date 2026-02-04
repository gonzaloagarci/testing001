#!/bin/bash

workdir=$(dirname "$0")
cd $workdir

uv run main.py "$@"