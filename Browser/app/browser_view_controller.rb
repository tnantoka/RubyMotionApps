class BrowserViewController < UIViewController
  def viewDidLoad
    #view.backgroundColor = UIColor.whiteColor
    #navigationController.setNavigationBarHidden(false, animated:true)
    navigationController.setToolbarHidden(false, animated:false)

    @webView = UIWebView.alloc.initWithFrame(
      CGRectMake(
        0, 
        0, 
        view.frame.size.width, 
        view.frame.size.height - navigationController.toolbar.frame.size.height - navigationController.navigationBar.frame.size.height
      )
    ) 
    @webView.delegate = self
    view.addSubview(@webView)

    @urlField = UITextField.alloc.initWithFrame(CGRectMake(0, 0, 310, 31))
    @urlField.font = UIFont.systemFontOfSize(14)
    @urlField.borderStyle = UITextBorderStyleRoundedRect
    @urlField.backgroundColor = UIColor.whiteColor
    @urlField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    @urlField.autocorrectionType = UITextAutocorrectionTypeNo
    @urlField.keyboardType = UIKeyboardTypeURL
    @urlField.returnKeyType = UIReturnKeyDone
    @urlField.delegate = self
    @urlField.text = 'http://google.com/'
    navigationItem.titleView = @urlField

    @backItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(101, target:@webView, action:'goBack')
    @forwardItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(102, target:@webView, action:'goForward')
    @relaodItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target:@webView, action:'reload')
    @stopItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemStop, target:@webView, action:'stopLoading')
    @stopItem.enabled = false

    toolbarItems = [
      @backItem, 
      @forwardItem,
      UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target:nil, action:nil),
      @relaodItem,
      @stopItem
    ]
    toolbarItems.each do |item|
      item.style = UIBarButtonItemStyleBordered
    end
    setToolbarItems(toolbarItems, animated:false)


    loadRequest('http://google.com/')
  end

  def loadRequest(urlString)
    url = NSURL.URLWithString(urlString)
    request = NSURLRequest.requestWithURL(url)
    @webView.loadRequest(request)
  end

  # - (BOOL)textFieldShouldReturn:(UITextField *)textField
  def textFieldShouldReturn(textField)
    urlString = textField.text
    if urlString.length > 1
      loadRequest(urlString)
    end
    textField.resignFirstResponder
    true
  end

  # - (void)webViewDidStartLoad:(UIWebView *)webView
  def webViewDidStartLoad(webView)
    UIApplication.sharedApplication.networkActivityIndicatorVisible = true 
    @stopItem.enabled = true
  end
 
  # - (void)webViewDidFinishLoad:(UIWebView *)webView
  def webViewDidFinishLoad(webView)
    UIApplication.sharedApplication.networkActivityIndicatorVisible = false 
    @backItem.enabled = @webView.canGoBack
    @forwardItem.enabled = @webView.canGoForward
    @stopItem.enabled = false
  end
 
  # - (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
  def webView(webView, didFailLoadWithError:error)
    webViewDidFinishLoad(webView)
  end

end
