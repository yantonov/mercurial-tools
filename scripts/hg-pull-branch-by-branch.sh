#!/bin/bash

# situation: hg verify informed about errors
# but it was possible to pull any selected branch
# this tiny snippet was helpful to preserve all latest changes

hg branches | cut -d \  -f 1 | xargs -I % hg pull -b %
