package com.example.lego.feature.starwars

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

data class SWCharacter(
    val id: String,
    val name: String,
    val affiliation: String,
    val actor: String
)

@HiltViewModel
class StarWarsViewModel @Inject constructor() : ViewModel() {

    private val _characters = MutableStateFlow<List<SWCharacter>>(emptyList())
    val characters: StateFlow<List<SWCharacter>> = _characters

    init {
        _characters.value = listOf(
            SWCharacter("1", "Luke Skywalker", "Jedi / Rebellion", "Mark Hamill"),
            SWCharacter("2", "Darth Vader", "Sith / Empire", "David Prowse / James Earl Jones"),
            SWCharacter("3", "Han Solo", "Rebellion", "Harrison Ford"),
            SWCharacter("4", "Leia Organa", "Rebellion", "Carrie Fisher"),
            SWCharacter("5", "Yoda", "Jedi", "Frank Oz")
        )
    }

    fun getCharacterById(id: String): SWCharacter? {
        return _characters.value.find { it.id == id }
    }
}
