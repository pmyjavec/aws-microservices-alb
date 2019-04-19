#!/usr/bin/env bash

cd shared/

terraform-docs markdown . > ../README.md
