//
//  WebServices.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit
import Foundation

typealias apiSuccess = (_ data: Data) -> ()
typealias apiFailure = (_ errorString: String) -> ()
typealias HTTPfailure = (_ errorString: String) -> ()

class WebServices {
    
    class func URLResponse(_ url:String ,parameters: [String: Any]?, headers: String?,  withSuccess success: @escaping apiSuccess, withapiFiluer failure: @escaping apiFailure) {
        
        let completeUrl : String = Constants.apiBaseUrl + url
        print(completeUrl)
        
        //Accordig to our requirement i'm doing only for GET request. We can make it generic
        var request = URLRequest(url: URL(string: completeUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            
            if(err != nil){
                
                print("error")
            }else{
                
                if let value = data {
  
                    success(value)
                }
            }
        }.resume()
    }
}


