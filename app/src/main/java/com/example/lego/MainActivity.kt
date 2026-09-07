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
import com.example.lego.feature.harrypotter.HarryPotterDetailsScreen
import com.example.lego.feature.starwars.StarWarsScreen
import com.example.lego.feature.startrek.StarTrekScreen
import com.example.lego.feature.dragonball.DragonBallScreen
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LegoTheme {
                LegoApp()
            }
        }
    }
}

@Composable
fun LegoApp() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = "lego_list") {
        composable("lego_list") {
            LegoListScreen(
                onNavigateToHarryPotter = { navController.navigate("harry_potter") },
                onNavigateToStarWars = { navController.navigate("star_wars") },
                onNavigateToStarTrek = { navController.navigate("star_trek") },
                onNavigateToDragonBall = { navController.navigate("dragon_ball") }
            )
        }
        composable("star_wars") {
            StarWarsScreen()
        }
        composable("star_trek") {
            StarTrekScreen()
        }
        composable("dragon_ball") {
            DragonBallScreen()
        }
        composable("harry_potter") {
            HarryPotterScreen(
                showBackButton = navController.previousBackStackEntry != null,
                onNavigateBack = { navController.popBackStack() },
                onCharacterClick = { characterId ->
                    navController.navigate("harry_potter_details/$characterId")
                }
            )
        }
        composable("harry_potter_details/{characterId}") { backStackEntry ->
            val characterId = backStackEntry.arguments?.getString("characterId") ?: return@composable
            HarryPotterDetailsScreen(
                characterId = characterId,
                onNavigateBack = { navController.popBackStack() }
            )
        }
    }
}
