#!/bin/bash

echo "==> Copy resolv.conf to base directory ${BASE_DIR}"
cp --dereference /etc/resolv.conf ${BASE_DIR}/etc/
