package com.example.lego.feature.legolist

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.compose.foundation.clickable

import androidx.compose.runtime.collectAsState

@Composable
fun LegoListScreen(
    viewModel: LegoListViewModel = hiltViewModel(),
    onNavigateToHarryPotter: () -> Unit = {}
) {
    val universes = viewModel.universes.collectAsState().value

    Surface(
        modifier = Modifier.fillMaxSize(),
        color = MaterialTheme.colorScheme.background
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = "Lego Worlds",
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold,
                color = Color.White,
                modifier = Modifier.padding(bottom = 16.dp)
            )
            LazyVerticalGrid(
                columns = GridCells.Adaptive(minSize = 150.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(universes.size) { index ->
                    val universe = universes[index]
                    LegoWorldCard(
                        universe = universe, 
                        onClick = { 
                            if (universe.id == "harry_potter") {
                                onNavigateToHarryPotter()
                            }
                        }
                    )
                }
            }
        }
    }
}

@Composable
fun LegoWorldCard(universe: LegoUniverse, onClick: () -> Unit) {
    Card(
        colors = CardDefaults.cardColors(
            containerColor = if (universe.isAvailable) MaterialTheme.colorScheme.surface else MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f)
        ),
        elevation = CardDefaults.cardElevation(defaultElevation = if (universe.isAvailable) 8.dp else 2.dp),
        shape = MaterialTheme.shapes.large,
        modifier = Modifier
            .fillMaxWidth()
            .aspectRatio(1f)
            .then(
                if (universe.isAvailable) Modifier.clickable { onClick() } else Modifier
            )
    ) {
        Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier.fillMaxSize().padding(8.dp)
        ) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Box(
                    modifier = Modifier
                        .size(64.dp)
                        .background(
                            if (universe.isAvailable) MaterialTheme.colorScheme.secondary else Color.Gray, 
                            shape = MaterialTheme.shapes.medium
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    Text("LEGO", color = Color.White, fontWeight = FontWeight.Bold)
                }
                Spacer(modifier = Modifier.height(12.dp))
                Text(
                    text = universe.title,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = if (universe.isAvailable) Color.White else Color.LightGray,
                    textAlign = androidx.compose.ui.text.style.TextAlign.Center
                )
                if (!universe.isAvailable) {
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        text = "(coming soon)",
                        fontSize = 12.sp,
                        color = Color.Gray
                    )
                }
            }
        }
    }
}
