

import Foundation

struct UserDC : Codable {
    
	let code : Int?
	let meta : String?
	let data : userData?
}

struct userData : Codable {
    
    let id : Int?
    let name : String?
    let email : String?
    let gender : String?
    let status : String?
}
