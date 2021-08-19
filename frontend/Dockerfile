FROM runmymind/docker-android-sdk:ubuntu-standalone

RUN mkdir /butterfly_frontend
WORKDIR /butterfly_frontend

COPY . /butterfly_frontend

RUN git clone https://github.com/flutter/flutter.git -b stable

ENV PATH $PATH:/flutter/bin/cache/dart-sdk/bin:/flutter/bin

RUN flutter doctor