FROM openjdk:8

LABEL maintainer="RongCloud"

# http hook tcp port
EXPOSE 80

ENV VERSION 3.0.6

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
# audio format: aac or wav
ENV AUDIO_FORMAT "aac"
# video quality: 1: high;2: low
ENV VIDEO_QUALITY 1

RUN apt-get update; \
	apt-get install -y --no-install-recommends supervisor

ADD ./rongrtc-record-*.tar.gz /opt/
ADD ./supervisord/* /etc/supervisor/conf.d/

VOLUME ["/data/record", "/var/log/supervisor"]

ENTRYPOINT ["/opt/rongrtc-record/start.sh"]

CMD ["sh", "-c", "tail -f /dev/null"]
