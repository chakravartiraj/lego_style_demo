package com.example.lego.feature.harrypotter

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

data class HPCharacter(
    val id: String,
    val name: String,
    val house: String,
    val actor: String
)

@HiltViewModel
class HarryPotterViewModel @Inject constructor() : ViewModel() {

    private val _characters = MutableStateFlow<List<HPCharacter>>(emptyList())
    val characters: StateFlow<List<HPCharacter>> = _characters

    init {
        // Load mock data
        _characters.value = listOf(
            HPCharacter("1", "Harry Potter", "Gryffindor", "Daniel Radcliffe"),
            HPCharacter("2", "Hermione Granger", "Gryffindor", "Emma Watson"),
            HPCharacter("3", "Ron Weasley", "Gryffindor", "Rupert Grint"),
            HPCharacter("4", "Draco Malfoy", "Slytherin", "Tom Felton"),
            HPCharacter("5", "Severus Snape", "Slytherin", "Alan Rickman")
        )
    }

    fun getCharacterById(id: String): HPCharacter? {
        return _characters.value.find { it.id == id }
    }
}
