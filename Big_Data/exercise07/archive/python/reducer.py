#!/usr/bin/env python

# Redurer template
import sys


def main(separator='\t'):
    prev_key = None
    cumsum = 0
    # Read the data line-by-line from STDIN
    for line in sys.stdin:
        # Get key and value from each line
        key, value = line.rstrip().split(separator, 1)

        if not prev_key == key:
            if prev_key is not None:
                # emit word with the sum of its occurrences
                print ('%s%s%d' % (prev_key, separator, cumsum))
            # (re)set temp variables
            prev_key = key
            cumsum = 0

        # for each word, increment counter
        cumsum += int(value)

    # Do not forget to emit the last pair
    if prev_key is not None:
        print ('%s%s%d' % (prev_key, separator, cumsum))

if __name__ == "__main__":
    main()