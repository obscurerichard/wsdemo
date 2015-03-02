#!/bin/bash
# Credit to Stack Overflow user Dave Dopson http://stackoverflow.com/a/246128/424301
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ulimit -n 99999
cd "$DIR"
supervisord -c supervisord.conf
