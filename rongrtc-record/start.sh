#!/bin/sh

set -e

echo "Record config init."
echo "-----------"
echo "VERSION: ${VERSION}"
echo "APPKEY: ${APPKEY}"
echo "SECRET: ${SECRET}"
echo "MEDIA_URL: ${MEDIA_URL}"
echo "RECORD_MODE: ${RECORD_MODE}"
echo "VIDEO_FORMAT: ${VIDEO_FORMAT}"
echo "AUDIO_FORMAT: ${AUDIO_FORMAT}"
echo "VIDEO_QUALITY: ${VIDEO_QUALITY}"
echo "LOG_LEVEL: ${LOG_LEVEL}"
echo "Video_Resolution: ${VIDEO_RESOLUTION}"
echo "BITRATE_LEVEL: ${BITRATE_LEVEL}"
echo "-----------"

cat > /opt/rongrtc-record/channel-state/ServiceSettings.properties<< EOF
recordType=1
port=80
recordNodeAddr=http://127.0.0.1:5000/record
appKey=${APPKEY}
secret=${SECRET}
appFilter=false
EOF

cat > /opt/rongrtc-record/record/bin/ServiceSettings.properties<< EOF
recordSaveDir=/data/record/
appKey=${APPKEY}
mediaUrl=${MEDIA_URL}
Publish_mode=${RECORD_MODE}

#视频格式: mkv/mp4/flv
VideoFormat=${VIDEO_FORMAT}
AudioFormat=${AUDIO_FORMAT}
SimulCast=${VIDEO_QUALITY}
#日志级别
#LOG_NONE_(0) LOG_FATAL_(1) LOG_ERR_(2) LOG_WARN_(3) LOG_INFO_(4) LOG_VERB_(5) LOG_HUGE_(6) LOG_DBG_(7)
LogLevel=${LOG_LEVEL}
#视频分辨率,只针对混屏模式
#480*320/320*480/640*480/480*640/1280*720/720*1280
VideoResolution=${VIDEO_RESOLUTION}
#码率级别 0: 较低，默认，width*height/1000  1:较高
BitrateLevel=${BITRATE_LEVEL}
EOF

service supervisor start
supervisorctl update
supervisorctl start all
supervisorctl status

exec "$@"
