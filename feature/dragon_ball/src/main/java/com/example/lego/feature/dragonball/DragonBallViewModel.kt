package com.example.lego.feature.dragonball

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

data class DBCharacter(
    val id: String,
    val name: String,
    val race: String,
    val voiceActor: String
)

@HiltViewModel
class DragonBallViewModel @Inject constructor() : ViewModel() {

    private val _characters = MutableStateFlow<List<DBCharacter>>(emptyList())
    val characters: StateFlow<List<DBCharacter>> = _characters

    init {
        _characters.value = listOf(
            DBCharacter("1", "Goku", "Saiyan", "Sean Schemmel"),
            DBCharacter("2", "Vegeta", "Saiyan", "Christopher Sabat"),
            DBCharacter("3", "Piccolo", "Namekian", "Christopher Sabat"),
            DBCharacter("4", "Gohan", "Half-Saiyan", "Kyle Hebert"),
            DBCharacter("5", "Frieza", "Frieza Race", "Daman Mills")
        )
    }

    fun getCharacterById(id: String): DBCharacter? {
        return _characters.value.find { it.id == id }
    }
}
