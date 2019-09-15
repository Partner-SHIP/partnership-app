```plantuml
@startuml AppCoordinator

package coordinator {

    interface ICoordinator {
         + bool                  fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false});
         + bool                  navigateToDynamicPage({@required String route, @required BuildContext context, @required Map<String, dynamic> args});
         + Future<FirebaseUser>  loginByEmail({@required String userEmail, @required String userPassword});
         + Future<FirebaseUser>  signUpByEmail({@required String newEmail, @required String newPassword});
         + Future<void>          disconnect();
         + StreamSubscription    subscribeToConnectivity(Function handler);
         + void                  showConnectivityAlert(BuildContext context);
         + FirebaseUser          getLoggedInUser();
         + AssetBundle           getAssetBundle();
    }
    
    class Coordinator {
        --fields--
        + {static} Coordinator instance
        - RoutingModule _router
        - ConnectivityModule _connectivity
        - AuthenticationModule _authentication
        - Map<String, AViewModel> _viewModels
        --methods--
        + {static} Coordinator Coordinator()
        - _internal()
        + Widget build(BuildContext context) <<Override>>
        - String _setUpInitialRoute()
        + bool fetchRegisterToNavigate(String route, BuildContext context, bool navigate = true, bool popStack = false)
        --getters--
        + AuthenticationModule authentication
        + ConnectivityModule connectivity
    }
    class PartnershipApp {
        + State<ParterShipApp> createState()
    }
}

@enduml
```