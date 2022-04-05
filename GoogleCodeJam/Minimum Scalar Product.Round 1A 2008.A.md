# Minimum Scalar Product

The problem statement and analysis can be found on [this link](https://codingcompetitions.withgoogle.com/codejam/round/00000000004330f6/0000000000432f33).

## Problem Statement

### Problem

You are given two vectors \(v_1 = (x_1, x_2, ..., x_n)\) and \(v_2 = (y_1, y_2, ..., y_n)\). The scalar product of these vectors is a single number, calculated as \(x_1y_1 + x_2y_2 + ... + x_ny_n\).

Suppose you are allowed to permute the coordinates of each vector as you wish. Choose two permutations such that the scalar product of your two new vectors is the smallest possible, and output that minimum scalar product.

### Input

The first line of the input file contains integer number \(\mathrm{T}\) - the number of test cases. For each test case, the first line contains integer number \(\mathrm{n}\). The next two lines contain \(\mathrm{n}\) integers each, giving the coordinates of \(v_1\) and \(v_2\) respectively.

### Output

For each test case, output a line

Case #X: Y
where X is the test case number, starting from 1, and Y is the minimum scalar product of all permutations of the two given vectors.

### Limits

Time limit: 30 seconds per test set.
Memory limit: 1GB.

### Small dataset (Test set 1 - Visible)

\(\mathrm{T} = 1000\)
\(1 ≤ \mathrm{n} ≤ 8\)
\(-1000 ≤ x_i, y_i ≤ 1000\)

### Sample

Input

```text
2
3
1 3 -5
-2 4 1
5
1 2 3 4 5
1 0 1 0 1
```

Output

```text
Case #1: -25
Case #2: 6
```

## Analysis

In spite of the geometric flavor in the name of this problem, it is truly a story of two arrays.

There are two permutations involved. However, after you fix the permutation for \(V_1\), you have complete freedom in choosing the permutation for \(V_2\). It is clear that the first permutation really does not matter. The important thing is which \(x_i\) gets to be matched to which \(y_j\).

To make thinking easier, we may assume that the first permutation has

\(x_1 ≤ x_2 ≤ ... ≤ x_n\). (1)
And our task is to match the \(y\)'s to the \(x\)'s so that the scalar product is as small as possible.

At this point, if you need a little exercise in the middle: Think about the case \(n = 2\), and just use a concrete example. What you will surely discover is that, in order to achieve the minimum scalar product, you always want to match the smaller \(x_i\) with the bigger \(y_j\).

What we would like to prove is: under condition (1), one of the optimal solutions is of the form

\(y_1 ≥ y_2 ≥ ... ≥ y_n\). (2)
The rigorous proof of (2) is given at the end of this analysis. For an easy reading, we point out that the key step is really the \(n = 2\) case. If \(x < x'\) and \(y < y'\), then

\((xy + x'y') - (xy' + x'y) = (x - x')(y - y') > 0\). (*)
So we prefer to match bigger \(y\)'s with smaller \(x\)'s.

Therefore, this problem is solved by the following simple algorithm.

```cpp
sort(v1.begin(), v1.end());
sort(v2.begin(), v2.end(), greater<int>());
long long ret = 0;
for (int i = 0; i < n; i++)
  ret += (long long)(v1[i]) * v2[i];
```

Proof of (2). We prove that any permutation that does not satisfy (2) can be transformed into one satisfying (2), and in each step we do not increase the scalar product.
Indeed, any unsorted array can be transformed to a sorted one by only interchanging adjacent elements that are out of order. (For more rigorous readers: prove this, maybe by counting the number of flipped pairs in the array.)
At each step, some \(x = x_i\) is matched to some \(y\), and \(x' = x_i+1\) is matched to some \(y\)' so that \(y ≤ y'\). We interchange \(y\) and \(y'\) in this step. The inequality similar to (*), with \(>\) replaced by \(≥\), tells us that the scalar product is not increased in this step. ◊

## Comments

这个问题的穷举法时间复杂度是阶乘级别的。这个方法类似贪心法，其关键在于如何用一个整体的数学关系去描述最小的配对状态，要能先猜对配对的状态，才能产生后续的论证。论证的方法是第二个难点，其困难在于逆序对数量变化的干扰，容易让人分神。具体来讲，一个逆序对的交换往往影响到整个序列中逆序对的数量非线性变化，容易陷入到去试图想清楚对其它逆序对的变化之中，但这对求点积来说不重要。
