```plantuml
@startuml AModelFactory

package models {
    abstract class AModelFactory {
        --fields--
        + {static} Map<String, AModel> register
        -- methods --
        + AModel AModelFactory(String route)
    }
}

@enduml
```