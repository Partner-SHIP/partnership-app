```plantuml
@startuml FBCollections

package utils {
    abstract class FBCollections {
        -- fields --
        + {static} String membership
        + {static} String groups
        + {static} String project
        + {static} String profiles
        -- getters --
        + {static} String[] CollectionsList()
    }
}

@enduml
```