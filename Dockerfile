FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/joebeachjoebeach/json-path-finder.git && \
    cd json-path-finder && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git && \
    sed -i 's/--check/--write/g' package.json

FROM node:alpine AS build

WORKDIR /json-path-finder
COPY --from=base /git/json-path-finder .
RUN npm install --global pnpm && \
    pnpm install && \
    pnpm run build

FROM lipanski/docker-static-website

COPY --from=build /json-path-finder/dist .
