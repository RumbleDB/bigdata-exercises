#!/usr/bin/env python

# Mapper template
import sys
import re


def main(separator='\t'):
    # Read the data line-by-line from STDIN
    # Use a cache to simulate a Combiner in memory
    cache = {}
    for line in sys.stdin:
        # Use regex to split on all non-alphanumeric characters.
        # You can also simply use line.lower().split(). In a real
        # application you would probably need a more sophisticated tokenizer.
        for word in re.split('\W+', line.lower()):
            word = word.strip()
            if len(word) > 0:
                if word not in cache:
                    cache[word] = 0
                cache[word] += 1

    # Loop over cache and emit all key-value pairs
    for key in cache:
    	print ('%s%s%d' % (key, separator, cache[key]))

if __name__ == "__main__":
    main()
