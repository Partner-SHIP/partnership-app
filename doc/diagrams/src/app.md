```plantuml
@startuml App

!include models.md
!include viewmodels.md
!include utils_uses.md
!include views.md
!include coordinator.md

title PartnerSHIP
legend
    Overall view of the architecture of the app
end legend

views.HomePage ---> HomePageViewModel
views.LoginPage ---> LoginPageViewModel
views.SignInPage ---> SignInPageViewModel
views.SignUpPage ---> SignUpPageViewModel
AViewModel ---> AppCoordinator

@enduml
```