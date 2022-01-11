package dev.alpaka.projectathens.ext

import android.view.View

var View.isInvisible: Boolean
    get() = visibility == View.VISIBLE
    set(value) {
        visibility = if (value) {
            View.INVISIBLE
        } else {
            View.VISIBLE
        }
    }
