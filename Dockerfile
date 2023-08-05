FROM ocaml/opam:debian-12-ocaml-4.14 AS build
RUN sudo ln -f /usr/bin/opam-2.2 /usr/bin/opam && opam init --reinit -ni
RUN sudo apt-get update
RUN cd ~/opam-repository && git fetch -q origin master && opam update
RUN mkdir ~/opam-archives
RUN cd ~/opam-repository && opam admin cache --link=archives ~/opam-archives

FROM busybox
WORKDIR /opam-archives
RUN chown 1000:1000 /opam-archives
COPY --from=build /home/opam/opam-archives /opam-archives
