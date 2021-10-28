//
//  PostsListDC.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import Foundation

struct PostsListDC : Codable {

	let code : Int?
	let meta : Meta?
	let data : [PostsData]?
}

struct PostsData : Codable {
    
    let id : Int?
    let user_id : Int?
    let title : String?
    let body : String?
}

struct Meta : Codable {
    
    let pagination : Pagination?
}

struct Pagination : Codable {
    
    let total : Int?
    let pages : Int?
    let page : Int?
    let limit : Int?
}
