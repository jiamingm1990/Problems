#include <stdio.h>
#include <stdlib.h>

static int choose(int n, int k);

int main() {
    const int tests[][2] = {
        {-1, 8},
        {-3, 7},
        {5, 2},
        {10, 5},
        {1000, 500},
        {-10, 9}};
    const size_t test_size = sizeof(tests)/(2 * sizeof(int));
    for (int i = 0; i < test_size; ++i) {
        printf("C(%d, %d) = %d\n", tests[i][0], tests[i][1], choose(tests[i][0], tests[i][1]));
    }
    return 0;
}

static int *init(int *row, size_t len) {
    *row = 1;
    for (int i = 1; i < len; ++i) {
        *(row+i) = 0;
    }
    return row;
}

/**
 * @brief Gets binomial coefficient with n >= 0 and k >= 0.
 *
 * @param n the upper index.
 * @param k the lower index.
 * @return int the value of binomial coefficient.
 */
static int pos_choose(int n, int k) {
    if (k < 0 || n < k) {
        return 0;
    }

    int *row = (int *) malloc((k+1) * sizeof(int));
    row = init(row, k+1);
    for (int r = 1; r < n; ++r) {
        for (int c = ((r < k) ? r : k); c >= 1; --c) {
            row[c] += row[c-1];
        }
    }

    int ans = 1;
    if (k > 0) {
        ans = row[k]+row[k-1];
    }

    free(row);
    return ans;
}

/**
 * @brief Gets binomial coefficient with arbitrary n and k >= 0.
 *
 * @param n the upper index.
 * @param k the lower index.
 * @return int the value of binomial coefficient.
 */
static int choose(int n, int k) {
    if (k < 0) {
        return 0;
    }

    int sign = 1;
    if (n < 0) {
        n = k - n - 1;

        if (k % 2 == 1) {
            sign = -1;
        }
    }

    return sign * pos_choose(n, k);
}