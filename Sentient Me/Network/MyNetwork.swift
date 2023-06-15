//
//  MyNetwork.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import Foundation
import Alamofire

class MyNetwork {
    
    static let shouldMockAPI = false
    public static let session = MyNetwork()
    var currentDownloadRequest: DownloadRequest?
    
    func request<T: Decodable>(method: HTTPMethod, urlPath: String, type: T.Type = T.self ,headers: [String:String]? = nil, queryParams:[String:Any]? = nil, bodyParams:[String: Any]? = nil, options:[String:Any]? = nil, onCompletion:((Result<T?,Error>)->Void)? = nil) {
        
        if (!(NetworkReachabilityManager()?.isReachable ?? false)) {
            onCompletion?(.failure(NetworkError.internetNotReachable))
            return
        }
        
        var urlPath = (urlPath.contains("http") ? "" : Constants.BASE_URL) + urlPath
        if let queryParams = queryParams, queryParams.count > 0 {
            urlPath = urlPath + "?" + queryParams.queryString
        }
        
        guard let fullUrl = URL(string: urlPath) else {
            onCompletion?(.failure(NetworkError.notAUrl(url: urlPath)))
            return
        }
        
        print("=====================> NetworkRequestStart \(Date()) URL:\(urlPath)")
        let headers = self.headers(customHeaders: headers)
        AF.request(fullUrl, method: method, parameters: bodyParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("=====================> NetworkRequestEnd \(Date()) URL:\(String(describing: response.request?.url?.absoluteURL))")
            if response.error != nil {
                onCompletion?(.failure(response.error!))
            } else if ((response.response?.statusCode ?? 0) < 200 || (response.response?.statusCode ?? 0) > 300) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                        print(json)
                    }
                    
                    let apiError = try JSONDecoder().decode(APIError.self, from: response.data!)
                    if response.request?.url?.absoluteString.contains("reset") ?? false || response.request?.url?.absoluteString.contains("password/verify") ?? false {
                        if response.response?.statusCode == 401 {
                            onCompletion?(.failure(NetworkError.alreadyUsed))
                        } else if response.response?.statusCode == 498 {
                            onCompletion?(.failure(NetworkError.tokenExpired))
                        } else {
                            onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                        }
                    } else {
                        onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                    }
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
                
            } else {
                do {
                    print("Success ::: \(String(describing: response))")
                    let result = try JSONDecoder().decode(T.self, from: response.data!)
                    onCompletion?(.success(result))
                    return
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
            }
        })
    }
    
    
    func uploadMedia<T: Decodable>(method: HTTPMethod, urlPath: String, type: T.Type = T.self ,imagesList : [UIImage], onCompletion:((Result<T?,Error>)->Void)? = nil) {
        
        if (!(NetworkReachabilityManager()?.isReachable ?? false)) {
            onCompletion?(.failure(NetworkError.internetNotReachable))
            return
        }
        
        let urlPath = (urlPath.contains("http") ? "" : Constants.BASE_URL) + urlPath
        
        guard let fullUrl = URL(string: urlPath) else {
            onCompletion?(.failure(NetworkError.notAUrl(url: urlPath)))
            return
        }
        let AuthorizationToken : String = "Bearer " // +(MyUserDefaults.standard.authenticationData?.accessToken ?? "")
        var urlRequest = URLRequest(url: fullUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
           urlRequest.httpMethod = "POST"
           urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
           urlRequest.addValue(AuthorizationToken, forHTTPHeaderField: "Authorization")
        
        print("=====================> NetworkRequestStart \(Date()) URL:\(urlPath)")
        AF.upload(multipartFormData: { multipartFormData in
            for image in imagesList{
                multipartFormData.append(image.pngData()!, withName: "files[]", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, with: urlRequest).responseJSON(completionHandler:
         {(response) in
            print("=====================> NetworkRequestEnd \(Date()) URL:\(String(describing: response.request?.url?.absoluteURL))")
            if response.error != nil {
                onCompletion?(.failure(response.error!))
            } else if (response.response?.statusCode != 200) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                        print(json)
                    }
                    let apiError = try JSONDecoder().decode(APIError.self, from: response.data!)
                    if response.request?.url?.absoluteString.contains("reset") ?? false || response.request?.url?.absoluteString.contains("password/verify") ?? false {
                        if response.response?.statusCode == 401 {
                            onCompletion?(.failure(NetworkError.alreadyUsed))
                        } else if response.response?.statusCode == 498 {
                            onCompletion?(.failure(NetworkError.tokenExpired))
                        } else {
                            onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                        }
                    } else {
                        onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                    }
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
                
            } else {
                do {
                    let result = try JSONDecoder().decode(T.self, from: response.data!)
                    print("Success ::: \(result)")
                    onCompletion?(.success(result))
                    return
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
            }
        }
                                                                 
        ).uploadProgress(queue: .main, closure: {progress in
            print("Progress ::: \(progress.fractionCompleted)")
        })
    
    }
    
    func downloadFile(method: HTTPMethod, fileName:String, urlPath: String, destinationPath: String? = nil ,headers: [String:String]? = nil, queryParams:[String:Any]? = nil, bodyParams:[String: Any]? = nil, options:[String:Any]? = nil, onProgress: ((Progress)->(Void))? = nil, onCompletion: @escaping (Result<String,Error>)->Void) {
        
        if (!(NetworkReachabilityManager()?.isReachable ?? false)) {
            onCompletion(.failure(NetworkError.internetNotReachable))
            
            return
        }
        
        guard let url = URL(string: urlPath) else {
            return onCompletion(.failure(NetworkError.notAUrl(url: urlPath)))
        }
        
        let destination: DownloadRequest.Destination = { _, _ in
            if let destination = destinationPath {
                return (URL(string: destination)!, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileExtension = "." + (url.lastPathComponent.split(separator: ".").last ?? "")
                let fileURL = documentsURL.appendingPathComponent((fileName.count > 0 ? fileName : "file").replacingOccurrences(of: " ", with: "_") + fileExtension)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        
        self.currentDownloadRequest = AF.download(url.absoluteString, headers: self.headers(customHeaders: nil),to: destination).downloadProgress(closure: { progress in
            onProgress?(progress)
        }).response { response in
            debugPrint(response)
            if response.error != nil {
                return onCompletion(.failure(response.error!))
            } else if let storedDocumentsPath = response.fileURL?.path {
                return onCompletion(.success(storedDocumentsPath))
            }
        }
    }
    
    func cancelCurrentDownloadRequest() {
        self.currentDownloadRequest?.cancel()
        self.currentDownloadRequest = nil
    }
    
    func headers(customHeaders: [String:String]?) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
//        if let token = MyUserDefaults.standard.authenticationData?.accessToken {
//            //Check to handle cases where we don't need to send the token even if token is present like anonymous feedback
//            if headers["Authorization"] != "" {
//                headers["Authorization"] = "Bearer \(token)"
//            }
//            headers["device-id"] = MyUserDefaults.standard.deviceId
//        }
        
        if let customHeaders = customHeaders {
            for key in customHeaders.keys {
                headers.add(HTTPHeader(name: key, value: customHeaders[key]!))
            }
        }
        return headers
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

enum NetworkError: Error, Equatable {
    case notAUrl(url: String)
    case internetNotReachable
    case apiError(message: String?)
    case invalidResetToken
    case alreadyUsed
    case tokenExpired
    
    func localizedDescription() -> String {
        switch self {
        case .notAUrl(let url):
            return "Not a valid url => \(url). Please provide a valid url."
        case .internetNotReachable:
            return "Internet not reachable"
        case .apiError(let message):
            return message ?? "Unknown Error"
        case .invalidResetToken:
            return "Invalid Reset Token"
        case .alreadyUsed:
            return "Already Used Token"
        case .tokenExpired:
            return "Reset Token Expired"
        }
    }
}

class Connectivity {
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

class APIError: Codable {
    var status: Bool?
    var message: String?
}


extension MyNetwork {
    
    class func showNetworkError(controller: UIViewController, error: Error) {
        let networkError = error as? NetworkError
        switch networkError {
        case .internetNotReachable:
            self.showNoNetworkError(controller: controller)
        default:
            break
        }
    }
    
    class func showNoNetworkError(controller: UIViewController) {
        let alert = AlertController.controller(title: "NoInternet.Title".localized, subTitle: "NoInternet.SubTitle".localized, okButtonText: "Retry")
        controller.present(alert, animated: true)
    }
}
