FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/joebeachjoebeach/json-path-finder.git && \
    cd json-path-finder && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM pierrezemb/gostatic

COPY --from=base /git/json-path-finder /srv/http
EXPOSE 8043
