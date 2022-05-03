#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#define DIGITS_LEN 7
#define DIGIT_LEN 19
#define DIGIT_MAX 9999999999999999999UL
#define DIGIT_BASE 10000000000000000000UL
#define DIGIT_HIGH_MAX 99999999999999UL
#define DIGIT_HIGH_BASE 100000000000000UL
#define DIGIT_SIGN 99999UL
typedef unsigned long long uint64;

static char *enc_char(char *raw, size_t len);
static char *enc_rev_char(char *raw, size_t len);

typedef struct {
    uint64 digits[DIGITS_LEN];
} int128d;

static void init_enc(int128d *num);
static void print_enc(int128d num);
static int128d enc(char *raw);
static char *dec(int128d num);
static int128d add(int128d num1, int128d num2);

int main() {
    char a[] = "7589123457391247392157392147389124573912437821389567";
    char b[] = "-6589123457391247392157392147389124573912437821389567";

    assert(0 == strcmp(
        enc_char(a, 129),
        "+00000000000000000000000000000000000000000000000000000000000000000000000000007589123457391247392157392147389124573912437821389567")
    );

    assert(0 == strcmp(
        enc_char(b, 129),
        "-00000000000000000000000000000000000000000000000000000000000000000000000000006589123457391247392157392147389124573912437821389567"
    ));

    assert(0 == strcmp(
        enc_rev_char(a, 129),
        "76598312873421937542198374129375129374219375432198570000000000000000000000000000000000000000000000000000000000000000000000000000+"
    ));

    assert(0 == strcmp(
        enc_rev_char(b, 129),
        "76598312873421937542198374129375129374219375432198560000000000000000000000000000000000000000000000000000000000000000000000000000-"
    ));

    int128d enc_a = enc(a);
    assert(4573912437821389567UL == enc_a.digits[0]);
    assert(4739215739214738912UL == enc_a.digits[1]);
    assert(75891234573912UL == enc_a.digits[2]);
    assert(0UL == enc_a.digits[3]);
    assert(0UL == enc_a.digits[4]);
    assert(0UL == enc_a.digits[5]);
    assert(0UL == enc_a.digits[6]);
    assert(0 == strcmp(dec(enc_a), a));

    int128d enc_b = enc(b);
    assert(5426087562178610433UL == enc_b.digits[0]);
    assert(5260784260785261087UL == enc_b.digits[1]);
    assert(9999934108765426087UL == enc_b.digits[2]);
    assert(DIGIT_MAX == enc_b.digits[3]);
    assert(DIGIT_MAX == enc_b.digits[4]);
    assert(DIGIT_MAX == enc_b.digits[5]);
    assert(DIGIT_MAX == enc_b.digits[6]);
    assert(0 == strcmp(dec(enc_b), b));
    
    int128d sum = add(enc_a, enc_b);
    assert(0UL == sum.digits[0]);
    assert(0UL == sum.digits[1]);
    assert(10000000000000UL == sum.digits[2]);
    assert(0UL == sum.digits[3]);
    assert(0UL == sum.digits[4]);
    assert(0UL == sum.digits[5]);
    assert(0UL == sum.digits[6]);
    assert(0 == strcmp(dec(sum), "1000000000000000000000000000000000000000000000000000"));
    
    return 0;
}

static char *enc_char(char *raw, size_t len) {
    char *encoded = (char *)malloc(len);
    memset(encoded, '0', len);

    if (*raw == '-') {
        *encoded = '-';
    } else {
        *encoded = '+';
    }

    char *src = raw;
    if (*raw == '+' || *raw == '-') {
        src = raw + 1;
    }

    size_t src_len = strlen(src);
    strcpy(encoded+129-src_len, src);
    return encoded;
}

static char *enc_rev_char(char *raw, size_t len) {
    char *encoded = (char *)malloc(len);
    memset(encoded, '0', len);

    if (*raw == '-') {
        *(encoded+len-1) = '-';
    } else {
        *(encoded+len-1) = '+';
    }

    char *src = raw;
    if (*raw == '+' || *raw == '-') {
        src = raw + 1;
    }

    size_t src_len = strlen(src);
    for (int i = 0; i < src_len; ++i) {
        *(encoded+i) = *(src+src_len-1-i);
    }

    return encoded;
}

static void init_enc(int128d *num) {
    memset(num->digits, 0, DIGITS_LEN * sizeof(uint64));
}

static void print_enc(int128d num) {
    for (int i = 0; i < DIGITS_LEN; ++i) {
        printf("%llu\t", num.digits[i]);
    }
    putchar('\n');
}

uint64 enc_digit(char *src, int sign, size_t digit_len) {
    uint64 enc_d;
    char digit[digit_len];
    strncpy(digit, src, digit_len);
    enc_d = atoll(digit);
    if (sign) { // negative
        enc_d = DIGIT_MAX - enc_d;
    }
    return enc_d;
}

static int128d enc(char *raw) {
    int128d encoded;
    init_enc(&encoded);

    int sign = 0; // positive
    if (*raw == '-') {
        sign = 1;
    }

    char *src = raw;
    if (*raw == '+' || *raw == '-') {
        src = raw + 1;
    }
    size_t src_len = strlen(src);

    int s_index = src_len - DIGIT_LEN;
    int digit_index = 0;
    while (s_index >= 0) {
        encoded.digits[digit_index] = enc_digit(src+s_index, sign, DIGIT_LEN);
        s_index -= DIGIT_LEN;
        ++digit_index;
    }

    if (s_index < 0 && s_index > -DIGIT_LEN) {
        encoded.digits[digit_index] = enc_digit(src, sign, DIGIT_LEN+s_index);
        ++digit_index;
    }

    if (sign) {
        while (digit_index < DIGITS_LEN) {
            encoded.digits[digit_index] = DIGIT_MAX - encoded.digits[digit_index];
            ++digit_index;
        }

        encoded.digits[0] += 1;
    }

    return encoded;
}

static int get_sign(int128d num) {
    int sign = 0; // positive
    if ((num.digits[DIGITS_LEN-1] / DIGIT_HIGH_BASE) == DIGIT_SIGN) {
        sign = 1;
    }
    return sign;
}

static int get_non_zero_index(int128d num, int sign) {
    int non_zero_index = DIGITS_LEN - 1;
    uint64 cur_digit;
    while(non_zero_index >= 0) {
        cur_digit = num.digits[non_zero_index];
        if (sign == 1) {
            cur_digit = DIGIT_MAX - cur_digit;
        }
        if (cur_digit != 0UL) {
            break;
        }
        --non_zero_index;
    };
    return non_zero_index;
}

static uint64 dec_digit(uint64 cur_digit, int sign, int is_first) {
    if (sign == 1) {
        if (is_first) {
            cur_digit -= 1;
        }
        cur_digit = DIGIT_MAX - cur_digit;
    }
    return cur_digit;
}

static char *dec(int128d num) {
    int sign = get_sign(num);
    int non_zero_index = get_non_zero_index(num, sign);

    char *dst = (char *)malloc((non_zero_index+1) * DIGIT_LEN + 1);
    char *dst_part = dst;
    if (sign == 1) {
        *dst_part = '-';
        ++dst_part;
    }
    int first_non_zero_index = non_zero_index;
    while (non_zero_index >= 0) {
        uint64 cur_digit = dec_digit(num.digits[non_zero_index], sign, non_zero_index == 0);
        char *format = non_zero_index == first_non_zero_index ? "%llu" : "%019llu";
        sprintf(dst_part, format, cur_digit);
        dst_part += strlen(dst_part);
        --non_zero_index;
    }
    return dst;
}

static int128d add(int128d num1, int128d num2) {
    int128d sum;
    init_enc(&sum);

    uint64 carry = 0UL;
    for (int i = 0; i < DIGITS_LEN; ++i) {
        uint64 digit_sum = num1.digits[i] + num2.digits[i] + carry;
        uint64 base = DIGIT_BASE;
        if (i + 1 == DIGITS_LEN) {
            base = DIGIT_HIGH_BASE;
        }
        sum.digits[i] = digit_sum % base;
        carry = digit_sum / base;
    }

    if (carry == 1) {
        // overflow exception.
    }

    return sum;
}