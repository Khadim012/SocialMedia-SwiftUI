//
//  HomeScreenModel.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import Foundation
import SwiftUI

enum PrefetchState {
    
    case fetching
    case idle
}

final class HomeScreenModel: ObservableObject {
    
    @Published var arrPostsList: [PostsData]?
    @Published var currPage = 1
    @Published var prefetchState: PrefetchState = .idle
    @Published var totalPages = 0
    
    init() {

        self.performWSToGetPostsList()
    }
    
    func preLoadigPostList(currListCount: Int, currIndex: Int) {
        
         //I'm checking the total list count with current list count
         if currListCount < self.totalPages {
             
             //We can change it according our requirements
             if currIndex > currListCount - 10 {
                 
                 //If the exciting api request is finished
                 if self.prefetchState == .idle {
                     
                     //page index update. loading status
                     self.prefetchState = .fetching
                     self.currPage = self.currPage + 1
                     self.performWSToGetPostsList()
                 }
             }
         }
    }
}

//MARK:- WebServices
extension HomeScreenModel {
    
    func performWSToGetPostsList() {
        
        WebServices.URLResponse("posts?page=\(currPage)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(PostsListDC.self, from: response)
                
                if let postsList = FULLResponse.data {
                    
                    DispatchQueue.main.async {
                        
                        if let currPage = FULLResponse.meta?.pagination?.page, currPage == 1 {
                            
                            //I'm saving total data count for pre loading.
                            if let total = FULLResponse.meta?.pagination?.total, total > 0 {
                                
                                self.totalPages = total
                            }
                            self.arrPostsList = postsList
                        }
                        else{
                    
                            self.arrPostsList! += postsList
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
