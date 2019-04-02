```plantuml
@startuml UtilsUSes

title PartnerSHIP UtilsUses 
legend
    Overall view of the utils utilisation of the application
end legend

!include Routes.md
!include FBCollections.md

LoginPageViewModel ---> Routes
SignUpPageViewModel ---> Routes
SignInPageViewModel ---> Routes
HomePageViewModel ---> Routes
views.testing_page ---> FBCollections

@enduml
```