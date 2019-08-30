```plantuml
@startuml App

!include AModel.md
!include ApiREST.md
!include AModelFactory.md
!include AppCoordinator.md
!include AuthenticationModule.md
!include AViewModel.md
!include AViewModelFactory.md
!include ConnectivityModule.md
!include LoginPage.md
!include LoginPageModel.md
!include LoginPageViewModel.md
!include ProfilePage.md
!include ProfilePageModel.md
!include ProfilePageViewModel.md
!include RoutingModule.md
!include SignInPage.md
!include SignInPageModel.md
!include SignInPageViewModel.md
!include SignUpPage.md
!include SignUpPageModel.md
!include SignUpPageViewModel.md

title PartnerSHIP
legend
    Overall view of the architecture of the application
                        MVVM-C PATTERN
end legend

ApiREST --|> IApiREST : implements
AModel --|> AModelFactory : implements
AModel --> IApiREST : uses
SignInPageModel --|> AModel : extends
SignUpPageModel --|> AModel : extends
ProfilePageModel --|> AModel : extends
LoginPageModel --|> AModel : extends
AViewModel --|> AViewModelFactory : implements
AViewModel --> ICoordinator : uses
PartnershipApp --> Coordinator : uses
RoutingModule --|> IRouting : implements
ConnectivityModule --|> IConnectivity : implements
AuthenticationModule --|> IAuthentication : implements
Coordinator --|> ICoordinator : implements
Coordinator --> IRouting : uses
Coordinator --> IConnectivity : uses
Coordinator --> IAuthentication : uses
LoginPageViewModel --|> AViewModel : extends
ProfilePageViewModel --|> AViewModel : extends
SignInPageViewModel --|> AViewModel : extends
SignUpPageViewModel --|> AViewModel : extends
ProfilePageState --> ProfileClipper : uses
SignUpPageState --> SignUpPageViewModel : uses
SignInPageState --> SignInPageViewModel : uses
LoginPageState --> LoginPageViewModel : uses
ProfilePageState --> ProfilePageViewModel : uses
SignUpPageViewModel --> SignUpPageModel : uses
SignInPageViewModel --> SignInPageModel : uses
ProfilePageViewModel --> ProfilePageModel : uses
LoginPageViewModel --> LoginPageModel : uses

@enduml
```