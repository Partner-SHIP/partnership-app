```plantuml
@startuml App

!include AModel.md
!include AModelFactory.md
!include AppCoordinator.md
!include AuthenticationModule.md
!include AViewModel.md
!include AViewModelFactory.md
!include ConnectivityModule.md
!include FBCollections.md
!include FBStreamWrapper.md
!include LoginPage.md
!include LoginPageModel.md
!include LoginPageViewModel.md
!include PayloadsFactory.md
!include ProfilePage.md
!include ProfilePageModel.md
!include ProfilePageViewModel.md
!include Routes.md
!include RoutingModule.md
!include SignInPage.md
!include SignInPageModel.md
!include SignInPageViewModel.md
!include SignUpPage.md
!include SignUpPageModel.md
!include SignUpPageViewModel.md

title PartnerSHIP
legend
    Overall view of the architecture of the app
end legend

AModel --|> AModelFactory
AModel --> FBStreamWrapper
SignInPageModel --|> AModel
SignUpPageModel --|> AModel
ProfilePageModel --|> AModel
LoginPageModel --|> AModel
AViewModel --|> AViewModelFactory
AViewModel --> Coordinator
PartnershipApp --> Coordinator
Coordinator --> RoutingModule
Coordinator --> ConnectivityModule
Coordinator --> AuthenticationModule
LoginPageViewModel --|> AViewModel
ProfilePageViewModel --|> AViewModel
SignInPageViewModel --|> AViewModel
SignUpPageViewModel --|> AViewModel
ProfilePageState --> ProfileClipper
SignUpPageState --> SignUpPageViewModel
SignInPageState --> SignInPageViewModel
LoginPageState --> LoginPageViewModel
ProfilePageState --> ProfilePageViewModel
SignUpPageViewModel --> SignUpPageModel
SignInPageViewModel --> SignInPageModel
ProfilePageViewModel --> ProfilePageModel
LoginPageViewModel --> LoginPageModel

@enduml
```