__author__ = 'Joshua Chin'

from wordfreq import simple_tokenize



def main(in_file, out_file, err):
    print("TOKENIZING", file=err)

    processed = 0
    last_print = 0
    step = 100000

    for line in in_file:
        if processed - last_print > step:
            last_print += step
            print("\033[1K\rProcessed %s tokens"%step, file=err, end='')

        tokens = simple_tokenize(line)
        print(" ".join(tokens), file=out_file)
        processed += len(tokens)

    print("\033[1K\rProcessed %s tokens"%processed, file=err)
    print(file=err)


if __name__ == '__main__':
    import sys
    main(sys.stdin, sys.stdout, sys.stderr)
