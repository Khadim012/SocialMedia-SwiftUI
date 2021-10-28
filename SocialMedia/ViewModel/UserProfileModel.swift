//
//  UserProfileModel.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit
import Foundation

class UserProfileModel: ObservableObject {

    @Published var userInfo: userData?
}

//MARK:- WebServices
extension UserProfileModel {
    
    func performWSToGetUserData(userID:String) {
       
        WebServices.URLResponse("users/\(userID)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(UserDC.self, from: response)
                
                if let userData = FULLResponse.data {
                    
                    DispatchQueue.main.async {
                        
                        self.userInfo = userData
                    }
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
