# rubocop:disable Lint/UnusedMethodArgument
class AppDelegate
  def application(_application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController =
      UINavigationController.alloc.initWithRootViewController(
        InflectorViewController.alloc.init
      )
    @window.makeKeyAndVisible
    true
  end
end
# rubocop:enable Lint/UnusedMethodArgument
