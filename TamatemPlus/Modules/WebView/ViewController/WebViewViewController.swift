//
//  WebViewViewController.swift
//  TamatemPlus
//
//  Created by zaid farouqi on 13/06/2023.
//

import UIKit
import WebKit

class WebViewViewController: BaseViewController {
    
    // MARK: outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var addressBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        loadWebviewWithUrl()
        
    }
    // MARK: initview : initialize the views in the controller
    func initView(){
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    // MARK: load webview with a givin url
    func loadWebviewWithUrl(){
        self.addressBar.text =  AppConstants.tamatemPlusLink
        guard let link = URL(string: AppConstants.tamatemPlusLink) else{
            return
        }
        let request = URLRequest(url: link)
        webView.load(request)
    }
    // MARK: close button action : pops the viewcontroller from navigation and goes back
    @IBAction func closePressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: refresh button action
    @IBAction func refreshPressed(_ sender: Any) {
        self.webView.reload()
    }
    // MARK: back button action : trigger webview to navigate backwards
    @IBAction func backPressed(_ sender: Any) {
        self.webView.goBack()
    }
    // MARK: forward button action : trigger webview to navigate forwards
    @IBAction func forwardPressed(_ sender: Any) {
        self.webView.goForward()
    }
    // MARK: share button action : displays apples native share sheet with text to share
    @IBAction func sharePressed(_ sender: Any) {
        let textToShare = [ webView.url?.absoluteString ?? AppConstants.tamatemPlusLink ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    // MARK: deinit : is called when the viewcontroller is removed from memory
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
}
// MARK: webview delegates extension
extension WebViewViewController : WKNavigationDelegate,WKUIDelegate{
    
    // MARK:  didFinish is called when the page finishes loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.addressBar.text = webView.url?.absoluteString ?? AppConstants.tamatemPlusLink
    }
    
    // MARK: didfail is called when page or webview fails
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        self.progressView.progress = 0
    }
    // MARK: this observer is to know the progress of the webpage that is loading
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            // MARK: reset progress when the page is fully loaded and delaying it for 1 second so it doesnt disapear fast
            if self.webView.estimatedProgress >= 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    self.progressView.progress = 0
                }
                
            }
        }
    }
    
}
