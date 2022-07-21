#!/usr/bin/env python3
"""mapper.py"""

import sys
import re

for line in sys.stdin:
    # Set to lowercase, remove punctuations and tokenize
    line = line.lower().strip()
    line = re.sub(r"[^\w\s]", "", line)
    words = line.split()
    for word in words:
        print('%s\t%s' % (word, 1))
