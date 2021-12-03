package com.mjm1990.time

import com.mjm1990.strings.isPalindrome
import java.time.LocalDate
import java.time.format.DateTimeFormatter

fun LocalDate.isPalindromeDay(): Boolean {
    return this.format(DateTimeFormatter.BASIC_ISO_DATE).isPalindrome()
}