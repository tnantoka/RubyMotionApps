class BrowserViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    #navigationController.setNavigationBarHidden(false, animated:true)
    navigationController.setToolbarHidden(false, animated:false)
  end
end
