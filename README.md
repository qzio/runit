Fork of Gerrit Pape's init `runit` [0]

Shutdown on `SIGTERM` to make runit more docker-friendly.

when docker 1.11 drops this will be redundant since docker will actually use `STOPSIGNAL` from your `Dockerfile`.

reported: https://github.com/docker/docker/issues/19300
fix: https://github.com/docker/docker/pull/20290

---
[0]http://smarden.org/runit/
