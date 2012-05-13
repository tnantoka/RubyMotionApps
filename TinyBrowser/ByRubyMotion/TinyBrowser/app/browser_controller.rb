class BrowserController < UIViewController
  def viewDidLoad
    navigationController.setToolbarHidden(false, animated:false)

    @webView = UIWebView.alloc.initWithFrame(view.bounds)
    view.addSubview(@webView)
    
    loadRequest("http://google.com/")
    
    @urlField = UITextField.alloc.initWithFrame(CGRectMake(0, 0, 300, 31)).tap do |uf|
      uf.backgroundColor = UIColor.whiteColor
      uf.delegate = self
      uf.text = "http://google.com/"
    end
    navigationItem.titleView = @urlField
    textFieldShouldReturn(@urlField)
  end
  
  def loadRequest(urlString)
    url = NSURL.URLWithString(urlString)
    request = NSURLRequest.requestWithURL(url)
    @webView.loadRequest(request)
  end
  
  def textFieldShouldReturn(textField)
    urlString = textField.text
    if urlString.length > 0
      loadRequest(urlString)
    end
    textField.resignFirstResponder
    true
  end
end
