#!/usr/bin/env bash

rm -rf classes
mkdir classes
scalac -feature -classpath classes/ -d classes/ setup.scala
