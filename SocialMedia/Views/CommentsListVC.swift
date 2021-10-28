//
//  CommentsListVC.swift
//  SocialMedia
//
//  Created by Khadim Hussain on 28/10/2021.
//

import SwiftUI

struct CommentsListVC: View {
    
    @StateObject private var commentsScreenView = CommentsScreenView()
    
    var body: some View {
        
        ZStack() {
            
            if let arrComments = commentsScreenView.arrCommentsList {
                
                List {
                    ForEach(0..<arrComments.count, id: \.self) {index in
                
                        let comment = arrComments[index]
                        
                        //list cell call
                        CommentsRows(comments: comment).onAppear(){
                            
                            //For pagination
                            //I'm checking the total list count with current list count
                            if arrComments.count < commentsScreenView.totalPages {
                              
                                //We can change it according our requirements
                                if index > arrComments.count - 10 {
                                    
                                    //If the exciting api request is finished
                                    if self.commentsScreenView.prefetchState == .idle {
                                        
                                        //page index update. loading status. pre loading request
                                        self.commentsScreenView.prefetchState = .fetching
                                        self.commentsScreenView.currPage = self.commentsScreenView.currPage + 1
                                        self.commentsScreenView.performWSToGetCommentsList()
                                    }
                                   
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(0)
        .navigationBarTitle(Text("Comments"), displayMode:  .inline)
    }
}

//List Cell implmentation
struct CommentsRows: View {
    
    let comments: commentsData
    var body: some View {
        
        HStack(alignment: .top) {
            
            Image("testUser")
                .resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 3.0))
                .frame(width: 62, height: 62, alignment: .center)
            
            VStack(alignment: .leading) {
                
                Text(comments.name ?? "")
                    .font(.headline)
                Text(comments.email ?? "")
                    .font(.title3)
                Spacer(minLength: 12)
                Text(comments.body ?? "")
                    .font(.subheadline)
                    .lineLimit(nil)
            }.padding(.leading,4)
        }.padding(.init(top: 8, leading: 0, bottom: 12, trailing: 0))
    }
}

struct CommentsListVC_Previews: PreviewProvider {
    static var previews: some View {
        CommentsListVC()
    }
}
