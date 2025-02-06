#!/bin/bash

set -e

container = sudo docker ps | awk '{print $1}'
