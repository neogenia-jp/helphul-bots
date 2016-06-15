#
# Dockerfile for Hubot
#
FROM node:0.12-slim

MAINTAINER WATARU MAEDA <w.maeda@neogenia.co.jp>

ENV HUBOT_NAME helphul-bot

ENV TERM dumb

# os settings
RUN \cp -fp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir -p /opt/hubot-root
WORKDIR /opt/hubot-root

EXPOSE 8080

CMD ["bin/hubot", "--name", "${HUBOT_NAME}", "--adapter", "slack"]

