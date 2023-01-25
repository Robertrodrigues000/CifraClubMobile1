package com.studiosol.cifraclub

import java.util.*

object LocaleHelper {
    fun buildUrlWithLocaleParam(url: String): String {
        return when (Locale.getDefault().language) {
            "pt" -> url
            "es" -> "$url?hl=es"
            else -> "$url?hl=en"
        }
    }
}