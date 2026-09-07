package com.example.lego

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.lego.designsystem.LegoTheme
import com.example.lego.feature.harrypotter.HarryPotterScreen
import com.example.lego.feature.legolist.LegoListScreen
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LegoTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    LegoAppNavigation()
                }
            }
        }
    }
}

@Composable
fun LegoAppNavigation() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = "lego_list") {
        composable("lego_list") {
            LegoListScreen()
        }
        composable("harry_potter") {
            HarryPotterScreen()
        }
    }
}
