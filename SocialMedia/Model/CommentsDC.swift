

import Foundation
struct CommentsDC : Codable {
    
	let code : Int?
	let meta : Meta?
	let data : [commentsData]?
}

struct commentsData : Codable {
    
    let id : Int?
    let post_id : Int?
    let name : String?
    let email : String?
    let body : String?
}
