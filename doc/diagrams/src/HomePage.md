```plantuml
@startuml HomePage

package views {
    class   HomePage {
        -- methods --
        + HomePageState createState() <<Override>>
    }
    
    class   HomePageState {
        -- fields --
        S    
        -- methods --
        + Widget build(BuildContext context) <<Override>>
    }
}

@enduml
```