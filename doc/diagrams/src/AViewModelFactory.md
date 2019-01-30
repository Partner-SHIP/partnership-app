```plantuml
@startuml AViewModelFactory

!include HomePageViewModel.md
!include LoginPageViewModel.md
!include SignInPageViewModel.md
!include SignUpPageViewModel.md

package viewmodel {
    class   AViewModelFactory {
        +test
    }
}

AViewModelFactory ---> HomePageViewModel
AViewModelFactory ---> LoginPageViewModel
AViewModelFactory ---> SignInPageViewModel
AViewModelFactory ---> SignUpPageViewModel
AViewModelFactory ---> AViewModel

@enduml
```