package com.example.lego.feature.startrek

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

data class STCharacter(
    val id: String,
    val name: String,
    val rank: String,
    val actor: String
)

@HiltViewModel
class StarTrekViewModel @Inject constructor() : ViewModel() {

    private val _characters = MutableStateFlow<List<STCharacter>>(emptyList())
    val characters: StateFlow<List<STCharacter>> = _characters

    init {
        _characters.value = listOf(
            STCharacter("1", "James T. Kirk", "Captain", "William Shatner"),
            STCharacter("2", "Spock", "Commander", "Leonard Nimoy"),
            STCharacter("3", "Leonard McCoy", "Lieutenant Commander", "DeForest Kelley"),
            STCharacter("4", "Nyota Uhura", "Lieutenant", "Nichelle Nichols"),
            STCharacter("5", "Hikaru Sulu", "Lieutenant", "George Takei")
        )
    }

    fun getCharacterById(id: String): STCharacter? {
        return _characters.value.find { it.id == id }
    }
}
