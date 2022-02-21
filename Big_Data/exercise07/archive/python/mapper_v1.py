#!/usr/bin/env python

# Mapper template
import sys
import re


def main(separator='\t'):
    # Read the data line-by-line from STDIN
    for line in sys.stdin:
        # Use regex to split on all non-alphanumeric characters.
        # You can also simply use line.lower().split(). In a real
        # application you would probably need a more sophisticated tokenizer.
        for word in re.split('\W+', line.lower()):
            word = word.strip()
            if len(word) > 0:
                key = word
                value = 1
                # Emit always the word as key and 1 as value
                print ('%s%s%d' % (key, separator, value))

if __name__ == "__main__":
    main()
