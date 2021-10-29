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
                            self.commentsScreenView.preLoadigCommentsList(currListCount: arrComments.count, currIndex: index)
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
                    Circle().stroke(Color.white, lineWidth: 2.0))
                .frame(width: 62, height: 62, alignment: .center)
            
            VStack(alignment: .leading) {
                
                Text(comments.name ?? "")
                    .font(.headline)
                Spacer(minLength:6)
                Text(comments.email ?? "")
                    .font(.subheadline)
                Spacer(minLength: 15)
                Text(comments.body ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
