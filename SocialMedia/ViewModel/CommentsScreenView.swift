//
//  CommentsScreenView.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class CommentsScreenView: ObservableObject {

    @Published var arrCommentsList: [commentsData]?
    @Published var currPage = 1
    @Published var prefetchState: PrefetchState = .idle
    @Published var totalPages = 0
    
    init() { self.performWSToGetCommentsList() }
}

//MARK:- WebServices
extension CommentsScreenView {
    
    func performWSToGetCommentsList() {
        
        WebServices.URLResponse("comments?page=\(currPage)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(CommentsDC.self, from: response)
                
                if let postsList = FULLResponse.data {
                    
                    
                    DispatchQueue.main.async {
                        if let currPage = FULLResponse.meta?.pagination?.page, currPage == 1 {
                            
                            //I'm saving total data for pre loading.
                            if let total = FULLResponse.meta?.pagination?.total, total > 0 {
                                
                                self.totalPages = total
                            }
                            self.arrCommentsList = postsList
                        }
                        else{
                            self.arrCommentsList! += postsList
                        }
                        //I'm using this to avoid double api request. If user will scroll fast then there are chance for double call
                        self.prefetchState = .idle
                    }
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
