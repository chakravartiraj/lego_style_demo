package com.example.lego.designsystem

import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

val ElectricIndigo = Color(0xFF6C63FF)
val NeonCyan = Color(0xFF03DAC6)
val DeepCharcoal = Color(0xFF121212)
val ElevatedDarkCard = Color(0xFF1E1E1E)

private val DarkColorScheme = darkColorScheme(
    primary = ElectricIndigo,
    secondary = NeonCyan,
    background = DeepCharcoal,
    surface = ElevatedDarkCard
)

@Composable
fun LegoTheme(
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colorScheme = DarkColorScheme,
        content = content
    )
}
