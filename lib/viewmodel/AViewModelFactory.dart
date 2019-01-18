/*
    Responsible for creating/managing all the ViewModel, accessible from the Coordinator.
*/
abstract class AViewModelFactory
{
  // Register to store and reuse (without changes in state) instanciated ViewModels
  static final Map<String, AViewModelFactory> register = <String, AViewModelFactory>{};

  // Factory to instanciate ViewModels from routes
  factory AViewModelFactory(String route)
  {
    if  (register.containsKey(route))
      return register[route];

    var viewModel;

    if (route.contains('foo'))
    {
      //viewModel = FooViewModel(); register[route] = viewModel;
    }
    else if (route.contains('bar'))
    {
      //viewModel = BarViewModel(); register[route] = viewModel;
    }
    return viewModel;
  }
}