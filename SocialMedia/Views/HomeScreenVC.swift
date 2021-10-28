//
//  HomeScreenVC.swift
//  SocialMedia
//
//  Created by Khadim Hussain on 27/10/2021.
//

import SwiftUI

struct HomeScreenVC: View {
    
    @StateObject private var homeScreenView = HomeScreenModel()
    
    var body: some View {
        
        NavigationView {
            
            if let arrPosts = homeScreenView.arrPostsList {
                
                List {
                    
                    ForEach(0..<arrPosts.count, id: \.self) {index in
                        
                        let post = arrPosts[index]
                        NavigationLink(destination: CommentsListVC()) {
                            
                            //list cell call
                            PostRows(post: post).onAppear(){
                               
                                //For pagination
                                //I'm checking the total list count with current list count
                                if arrPosts.count < homeScreenView.totalPages {
                                    
                                    //We can change it according our requirements
                                    if index > arrPosts.count - 10 {
                                        
                                        //If the exciting api request is finished
                                        if self.homeScreenView.prefetchState == .idle {
                                            
                                            //page index update. loading status
                                            self.homeScreenView.prefetchState = .fetching
                                            self.homeScreenView.currPage = self.homeScreenView.currPage + 1
                                            self.homeScreenView.performWSToGetPostsList()
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Home Screen", displayMode:  .inline)
            }
        }.padding(.all,0)
    }
}

//List Cell implmentation
struct PostRows: View {
    @State private var selection: String? = nil
    let post: PostsData
    var body: some View {
        
        HStack(alignment: .top) {
            
            NavigationLink(destination: UserProfileVC(userID: post.user_id ?? 0), tag: "A", selection: $selection) { EmptyView() }.hidden().frame(width: 0 , height: 0)
            Image("testUser")
                .resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 3.0))
                .frame(width: 62, height: 62, alignment: .center)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selection = "A"
                        }
                )
            
            VStack(alignment: .leading) {
                
                Text("User ID: \(post.user_id ?? 0)")
                    .font(.title)
                Text(post.title ?? "")
                    .font(.headline)
                Spacer(minLength: 12)
                Text(post.body ?? "")
                    .font(.subheadline)
                    .lineLimit(nil)
            }.padding(.leading,4)
            
            
        }.padding(.init(top: 8, leading: 0, bottom: 12, trailing: 0))
    }
    
}

struct HomeScreenVC_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenVC()
    }
}
