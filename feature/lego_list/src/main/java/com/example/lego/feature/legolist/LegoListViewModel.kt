package com.example.lego.feature.legolist

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

data class LegoUniverse(
    val id: String,
    val title: String,
    val isAvailable: Boolean
)

@HiltViewModel
class LegoListViewModel @Inject constructor() : ViewModel() {
    private val _universes = MutableStateFlow<List<LegoUniverse>>(emptyList())
    val universes: StateFlow<List<LegoUniverse>> = _universes

    init {
        _universes.value = listOf(
            LegoUniverse("harry_potter", "Harry Potter Universe", true),
            LegoUniverse("star_war", "Star War Universe", false),
            LegoUniverse("star_trek", "Star Trek Universe", false),
            LegoUniverse("dragon_ball", "Dragon Ball-Z Universe", false)
        )
    }
}
