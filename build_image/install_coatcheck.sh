#!/bin/bash
add-apt-repository ppa:avsm/ppa
apt update
apt install opam
#mv ~/.opam ~/.opam.bak
opam init --disable-sandboxing
opam switch create 4.01.0
eval $(opam env)
opam install opam-depext
opam-depext coq
apt-get install -y m4
opam pin add -y coq 8.4.5
#coqc --version
git clone https://github.com/daniellustig/coatcheck.git
cd coatcheck && make
