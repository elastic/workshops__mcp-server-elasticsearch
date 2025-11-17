# Copyright Elasticsearch B.V. and contributors
# SPDX-License-Identifier: Apache-2.0
FROM cgr.dev/chainguard/wolfi-base:latest@sha256:42012fa027adc864efbb7cf68d9fc575ea45fe1b9fb0d16602e00438ce3901b1

RUN apk --no-cache add nodejs npm

WORKDIR /app

# Install dependencies (Docker build cache friendly)
COPY package.json package-lock.json tsconfig.json ./
RUN touch index.ts && npm install

COPY *.ts run-docker.sh ./
RUN npm run build

# Future-proof the CLI and require the "stdio" argument
ENV RUNNING_IN_CONTAINER="true"

ENTRYPOINT ["./run-docker.sh"]
