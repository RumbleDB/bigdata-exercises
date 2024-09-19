#!/usr/bin/env python

# Use the some modules
import io
import sys, time


# 'file' in this case is STDIN
def read_input(file):
    # Split each line into words
    for line in file:
        yield line.split()


def main(separator='\t'):
    # Define some Variables
    total_count = 0
    word_freq = {}
    start = time.time()
    # Read the data using read_input
    print ('Start processing...')
    if sys.version_info >= (3,0):
        stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8',  errors='replace')
    else:
        stream = sys.stdin
    data = read_input(stream)
    # Process each words returned from read_input
    for words in data:
        # Process each word
        for word in words:
            total_count += 1
            word_freq[word] = word_freq[word] + 1 if word in word_freq else 1
    # Save output
    with open('wordcountout.txt', 'w') as outfile:
        for w, f in word_freq.items():
            outfile.write ('%s%s%d\n' % (w, separator, f))

    print ('Total number of words: %d' % total_count)
    print ('Total time: %.3f seconds' % (time.time() - start))


if __name__ == "__main__":
    main()
