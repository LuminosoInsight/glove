__author__ = 'Joshua Chin'

import numpy as np


def main(size, in_file, out_file):
    vecs = np.fromfile(in_file).reshape((-1, size+1))
    pivot = vecs.shape[0] // 2
    vecs[:pivot] += vecs[pivot:]
    np.save(out_file, vecs[:pivot, :-1])


if __name__ == '__main__':
    import sys
    if len(sys.argv) == 1:
        print("Tool to convert binary GloVe vectors to numpy array")
        print("Example Usage: ./convert.py 300 vectors.npy")
    else:
        print("CONVERTING BINARY FILE")
        main(int(sys.argv[1]), open(sys.argv[2], mode='rb'), open(sys.argv[3], mode='wb'))
