```plantuml
@startuml AuthenticationModule

package coordinator {
    class   AuthenticationModule {
        --fields--
        + {static} AuthenticationModule instance
        - FirebaseAuth _auth
        - FirebaseUser _loggedInUser
        --methods--
        + {static} AuthenticationModule AuthenticationModule()
        - _internal()
        + Future<FirebaseUser> loginByEmail(String userEmail, String userPassword) <<async>>
        + Future<FirebaseUser> signUpByEmail(String newEmail, String newPassword) <<async>>
    }
}

@enduml
```