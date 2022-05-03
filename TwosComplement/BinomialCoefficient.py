def pos_choose(n, k):
    if k < 0 or n < k:
        return 0

    row = [0] * (k+1)
    row[0] = 1
    for r in range(1, n):
        for c in range(min(r, k), 0, -1):
            row[c] += row[c-1]

    ans = 1
    if k > 0:
        ans = row[k] + row[k-1];

    return ans

def choose(n, k):
    if k < 0:
        return 0

    sign = 1
    if n < 0:
        n = k - n - 1

        if k % 2 == 1:
            sign = -1

    return sign * pos_choose(n, k)

def main():
    tests = [
        (-1, 8),
        (-3, 7),
        (5, 2),
        (10, 5),
        (1000, 500),
        (-10, 9)
    ]
    for test in tests:
        print(f"C({test[0]}, {test[1]}) = {choose(test[0], test[1])}")

if __name__ == '__main__':
    main()