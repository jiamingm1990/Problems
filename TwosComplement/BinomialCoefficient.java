public class BinomialCoefficient {
    private final int upperIndex;
    private final int lowerIndex;

    public BinomialCoefficient(int upperIndex, int lowerIndex) {
        this.upperIndex = upperIndex;
        this.lowerIndex = lowerIndex;
    }

    public int upperIndex() {
        return upperIndex;
    }

    public int lowerIndex() {
        return lowerIndex;
    }

    public int value() {
        if (lowerIndex < 0) {
            return 0;
        }

        int sign = 1;
        int n = upperIndex;
        if (n < 0) {
            n = lowerIndex - n - 1;

            if (lowerIndex % 2 == 1) {
                sign = -1;
            }
        }

        return sign * choose(n, lowerIndex);
    }

    // Gets binomial coefficient with n >= 0 and k >= 0.
    private int choose(int n, int k) {
        if (k < 0 || n < k) {
            return 0;
        }

        final int[] row = new int[k+1];
        row[0] = 1;
        for (int r = 1; r < n; ++r) {
            for (int c = ((r < k) ? r : k); c >= 1; --c) {
                row[c] += row[c-1];
            }
        }

        int ans = 1;
        if (k > 0) {
            ans = row[k] + row[k-1];
        }
        
        return ans;
    }

    public static void main(String[] args) {
        final int[][] tests = new int[][]{
            {-1, 8},
            {-3, 7},
            {5, 2},
            {10, 5},
            {1000, 500},
            {-10, 9}};
        for (int i = 0; i < tests.length; ++i) {
            System.out.println(
                String.format("C(%d, %d) = %d", 
                    tests[i][0], tests[i][1], 
                    new BinomialCoefficient(tests[i][0], tests[i][1]).value()));
        }
    }
}