# cd /Users/rosstyzackpitman/Documents/NaturalState/CTEC/Apps/NIP/NIP-Dashboard/dev/superset-aks-dev
# docker build -t naturalstate/superset:dev-3.0.0 -f dockerfile .
# docker push naturalstate/superset:dev-3.0.0

# FROM apache/superset:3.0.0
FROM apache/superset:2.1.3

USER root

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install --no-install-recommends -y firefox-esr

ENV GECKODRIVER_VERSION=0.30.0
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz && \
    tar -x geckodriver -zf geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz -O > /usr/bin/geckodriver && \
    chmod 755 /usr/bin/geckodriver && \
    rm geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz

RUN pip install webdriver-manager

RUN pip install --no-cache gevent psycopg2 redis

RUN pip install "apache-superset[databricks]"

#####

# ARG PY_VER=3.9-slim-bookworm

# if BUILDPLATFORM is null, set it to 'amd64' (or leave as is otherwise).
# ARG BUILDPLATFORM=${BUILDPLATFORM:-amd64}
# FROM --platform=${BUILDPLATFORM} node:16-slim AS superset-node

# ARG NPM_BUILD_CMD="build"

# RUN apt-get update -q \
#     && apt-get install -yq --no-install-recommends \
#         python3 \
#         make \
#         gcc \
#         g++

# ENV BUILD_CMD=${NPM_BUILD_CMD} \
#     PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# # NPM ci first, as to NOT invalidate previous steps except for when package.json changes
# WORKDIR /app/superset-frontend

# COPY ./docker/frontend-mem-nag.sh /

# RUN /frontend-mem-nag.sh

# COPY superset-frontend/package*.json ./

# RUN npm ci

# COPY ./superset-frontend ./

# # This seems to be the most expensive step
# RUN npm run ${BUILD_CMD}

######

USER superset