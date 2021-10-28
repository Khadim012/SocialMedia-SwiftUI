//
//  UserProfileVC.swift
//  SocialMedia
//
//  Created by Khadim Hussain on 28/10/2021.
//

import SwiftUI

struct UserProfileVC: View {
    
    @StateObject private var userProfileView = UserProfileModel()
    
    var userID = 0
 
    var body: some View {
  
        VStack {
            
            ZStack {
                
                Image("icn_profile_cover")
                    .resizable()
                ZStack {
                    
                    Image("fontSizeGradient")
                        .resizable()
                }
                
            }.frame(maxWidth: .infinity, maxHeight: 240)
            
            ZStack {
                
                VStack(alignment: .center) {
                    
                    Image("testUser")
                        .resizable()
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 3.0))
                        .frame(width: 92, height: 92, alignment: .center)
                    Spacer(minLength: 20)
                    Text(userProfileView.userInfo?.name ?? "")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(userProfileView.userInfo?.email ?? "")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 20)
                    HStack {
                        
                        Text("Status :")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(userProfileView.userInfo?.status ?? "active")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: 20)
            Spacer()
        }
        .navigationBarTitle(Text("User Profile"), displayMode:  .inline)
        .navigationBarHidden(false)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            
            self.userProfileView.performWSToGetUserData(userID: "\(userID)")
        })
    }
}

struct UserProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileVC()
    }
}
