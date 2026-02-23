#!/usr/bin/env bash
set -e

# Runs Jupyter Notebook on Jetson Nano
# Access from Nano browser: http://127.0.0.1:8888
# Access from another device on same network:
#   http://<JETSON_IP>:8888

export OPENBLAS_CORETYPE=ARMV8

echo "Starting Jupyter..."
python3 -m notebook --ip=0.0.0.0 --no-browser --port=8888
