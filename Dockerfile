FROM ubuntu:18.04

LABEL maintainer="RongCloud"

# http hook tcp port
EXPOSE 80

ENV VERSION 3.0.14

ENV APPKEY ""
ENV SECRET ""
ENV MEDIA_URL "https://rtc-info.ronghub.com"
# record mode:
# 0: separate file for each user
# 1: separate file for each user, video recording only
# 2: separate file for each user, audio recording only
# 3: one file for all users
# 4: one file for all users, video recording only
# 5: one file for all users, audio recording only
ENV RECORD_MODE 3

#video format: mkv/mp4/flv
ENV VIDEO_FORMAT "mkv"
# audio format: aac or wav
ENV AUDIO_FORMAT "aac"
# video quality: 1: high;2: low
ENV VIDEO_QUALITY 1
#日志级别
#LOG_NONE_(0) LOG_FATAL_(1) LOG_ERR_(2) LOG_WARN_(3) LOG_INFO_(4) LOG_VERB_(5) LOG_HUGE_(6) LOG_DBG_(7)
ENV LOG_LEVEL 4

#视频分辨率,只针对混屏模式
#480*320/320*480/640*480/480*640/1280*720/720*1280
ENV VIDEO_RESOLUTION "640*480"

#视频码率级别 0: 较低，默认，width*height/1000  1:较高
ENV BITRATE_LEVEL 0

ADD ./sources.list  /etc/apt/

RUN apt-get update; \
	apt-get install -y --no-install-recommends \
	supervisor wget openjdk-8-jdk; \
	apt-get clean

ADD ./rongrtc-record-*.tar.gz /opt/
ADD ./supervisord/* /etc/supervisor/conf.d/

VOLUME ["/data/record", "/var/log/supervisor"]

ENTRYPOINT ["/opt/rongrtc-record/start.sh"]

CMD ["sh", "-c", "tail -f /dev/null"]
