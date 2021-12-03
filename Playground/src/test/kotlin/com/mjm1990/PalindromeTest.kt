package com.mjm1990

import com.mjm1990.time.isPalindromeDay
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import java.time.LocalDate
import java.time.temporal.ChronoUnit

class PalindromeTest {
    @Test
    fun numberOfPalindromeSince() {
        val beginDate = LocalDate.of(1000, 1, 1)
        val endDate = LocalDate.of(9999, 12, 31)
        val palindromeDays = numberOfPalindrome(beginDate, endDate)
        val totalDays = ChronoUnit.DAYS.between(beginDate, endDate) + 1

        assertEquals(331, palindromeDays)
        assertEquals(3287182, totalDays)
        assertEquals("100.69 ppm", String.format("%.2f ppm", palindromeDays * 1000000.0 / totalDays))
    }

    private fun numberOfPalindrome(beginDate: LocalDate, endDate: LocalDate): Int {
        var total = 0
        var offset = 0L
        while (offset < ChronoUnit.DAYS.between(beginDate, endDate)) {
            val date = beginDate.plusDays(offset)
            if (date.isPalindromeDay()) {
                ++total
            }
            ++offset
        }
        return total
    }
}