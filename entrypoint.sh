#!/bin/sh

cd /app

jupyter notebook --port=8889 --ip="0.0.0.0" --no-browser --allow-root .