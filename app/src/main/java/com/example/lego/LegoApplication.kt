package com.example.lego

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class LegoApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Initialization code can go here
    }
}
