package com.mjm1990.strings

fun String.isPalindrome(): Boolean {
    if (this.length % 2 != 0) {
        return false
    }

    var index = 0
    while (index < this.length / 2) {
        if (this[index] != this[this.length - 1 - index]) {
            return false
        }
        ++index
    }
    return true
}