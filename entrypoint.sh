#!/bin/sh

rails db:setup

exec "$@"
