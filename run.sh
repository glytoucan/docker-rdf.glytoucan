#!/bin/sh
mvn --debug -U -DskipTests=true clean package spring-boot:run
