FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/joebeachjoebeach/json-path-finder.git && \
    cd json-path-finder && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM lipanski/docker-static-website

COPY --from=base /git/json-path-finder .
