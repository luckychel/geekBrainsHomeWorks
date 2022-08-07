//
//  LoginWebViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 07.08.2022.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController {
    
    @IBOutlet var vkWebView: WKWebView!

    let session = Session.shared
    let vkApi = VKApi.shared
    
    let urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "oauth.vk.com"
            urlComponents.path = "/authorize"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: VKApi.clientId),
                URLQueryItem(name: "redirect_uri", value: VKApi.redirectUrl),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "response_type", value: "token"),
            ]
            return urlComponents
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = urlComponents.url!
        guard  UIApplication.shared.canOpenURL(url) else
        {
            preconditionFailure("Некорректный URL или ресурс не доступен")
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        vkWebView.navigationDelegate = self
        
        let request = URLRequest(url: url)
        vkWebView.load(request)

    }
    
}

extension LoginWebViewController: WKNavigationDelegate{

    func webView( _ webView: WKWebView,
                  decidePolicyFor navigationResponse: WKNavigationResponse,
                  decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, params in
                var dict = result
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
            }
            guard
                let token = parameters["access_token"],
                let userIDString = parameters["user_id"],
                let userID = Int(userIDString)
            else {decisionHandler(.allow)
               return
            }

        session.token = token
        session.userId = userID

        vkApi.getFriendsList(token: session.token, id: session.userId)
        vkApi.getUserPhotos(token: session.token, id: session.userId)
        vkApi.getUserGroups(token: session.token, id: session.userId)
        vkApi.getUserGroupsSearch(token: session.token)
        performSegue(withIdentifier: "LoginWeb", sender: nil)
        decisionHandler(.cancel)

    }

}
