#!/bin/sh

ps -ef|grep Recorder|grep -v grep|awk '{print $2}'|xargs kill -9 >/dev/null 2>&1
export LD_LIBRARY_PATH=/opt/rongrtc-record/record/libs
/opt/rongrtc-record/record/bin/Recorder --port 5000
