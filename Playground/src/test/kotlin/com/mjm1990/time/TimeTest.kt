package com.mjm1990.time

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import java.time.LocalDate

class TimeTest {
    @Test
    fun isPalindromeDay() {
        assertTrue(LocalDate.of(2021, 12, 2).isPalindromeDay())
        assertFalse(LocalDate.of(2021, 12, 3).isPalindromeDay())
    }
}