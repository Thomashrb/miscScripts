#!/usr/bin/env fish
# Small script from the Vundle FAQ to use vundle with fish
env SHELL=(which sh) vim +BundleInstall! +BundleClean +qall
