package com.mjm1990.strings

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test

class StringTest {
    @Test
    fun isPalindrome() {
        assertTrue("".isPalindrome())
        assertTrue("20211202".isPalindrome())
        assertFalse("20211203".isPalindrome())
        assertFalse("2021111".isPalindrome())
    }
}