FROM runmymind/docker-android-sdk:ubuntu-standalone

RUN mkdir /butterfly_frontend
WORKDIR /butterfly_frontend

COPY . /butterfly_frontend

# Install flutter
# RUN apt-get update && \
#     apt-get install -y lcov git-core curl unzip && \
#     git clone https://github.com/flutter/flutter.git && \
#     /flutter/bin/flutter doctor && \
#     apt-get remove -y curl unzip && \
#     apt autoremove -y && \
#     rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flutter/flutter.git -b stable
#ENV PATH "$PATH:/home/developer/flutter/bin"

ENV PATH $PATH:/flutter/bin/cache/dart-sdk/bin:/flutter/bin

RUN flutter doctor