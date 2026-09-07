pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "LegoStyleDemo"
include(":app")
include(":core:design_system")
include(":feature:harry_potter")
include(":feature:lego_list")
include(":feature:star_wars")
include(":feature:star_trek")
include(":feature:dragon_ball")
