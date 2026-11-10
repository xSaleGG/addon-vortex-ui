# Home Assistant base image
ARG BUILD_FROM

# first stage, can't use alpine for building armv7
FROM node:22 AS builder
WORKDIR /app
ARG VORTEX_UI_VERSION

### Vortex UI source
RUN test -n "$VORTEX_UI_VERSION" && \
  git clone --depth 1 --branch "$VORTEX_UI_VERSION" https://github.com/xSaleGG/vortex-ui . && \
  npm ci && \
  npm run build && \
  npm prune --omit=dev && \
  rm -rf ./data/*

# second stage
FROM $BUILD_FROM
WORKDIR /rootfs

# copy files to /rootfs
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js .
COPY --from=builder /app/package.json .

# copy run
COPY run.sh /

# install node, symlink persistent data and chmod run
RUN apk add --no-cache nodejs-current && \
  ln -s /rootfs/data /data && \
  chmod a+x /run.sh

# set add-on environment
ENV PORT=8099 \
  NODE_ENV=production \
  ADDON=true

CMD [ "/run.sh" ]
