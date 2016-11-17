import Foundation
import PlaygroundSupport


protocol JSONable {
    init?(json: [String: Any])
    func toJson() -> [String:Any]
}



//Added equatable protcol to compare these diff properties in this struct
//struct PlaceholderPost: Equaltable
// different types of PROTOCOLS available here
struct PlaceholderPost {
    //1. what values needed to return for posts (Postman)
    //2. create the instance vars
    //3. parse out into 100 Placeholders (in func - create an array)
    let userId: Int
    let id: Int
    let title: String
    let body: String
    //let email: String = ""
    
    //function to turn code back into Json Dict??
    /*func toJson() -> [String : Any] {
        let jsonLiteralDict: [String: Any] = [
            "userId": self.userId,
            "id": self.id,
            "title": self.title,
            "body": self.body
        ]
        return PlaceholderPost(json: jsonLiteralDict)
    }*/
    
    init?(json: [String : Any]) {
        if let userId = json["userId"] as? Int,
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let body = json["body"] as? String {
            self.userId = userId
            self.id = id
            self.title = title
            self.body = body
        } else {
            return nil
        }
    }
}

struct PlaceHolderComments {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init?(json: [String:Any]) {
        if
            let postId = json["postId"] as? Int,
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let email = json["email"] as? String,
            let body = json["body"] as? String {
            self.postId = postId
            self.id = id
            self.name = name
            self.email = email
            self.body = body
        } else {
            return nil
        }
    
        func toJson() -> [String:Any] {
            let myDict: [String:Any] = [
                "id" : self.id,
                "postId" : self.postId,
                "email" : self.email,
                "body" : self.body
            ]
            return myDict
        }
    }
}

/**   CAN YOU CREATE ONE FUNCTION TO DO ALL OF THESE??   **/

//URL Session simple REST API calls
func baselineURLSession() {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let url = URL(string: "https://randomuser.me/api")!
    session.dataTask(with: url, completionHandler: { (data: Data?, _, error: Error?) in
        
        if error != nil {
            print(error!)
        }
        
        if data != nil {
            print("YAYYYY DATA: \(data!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                
                if let validJson = json {
                    print(validJson)
                }
            }
            catch {
                print("Problem casting json: \(error)")
            }
            
        }
    }).resume()
}

//using URL GET Request
func newRequest() {
    let url = URL(string: "https://randomuser.me/api")!
    
    //GET method requesting from API
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept") //adds something?
    
    //URL Session
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: request) {(data: Data?, _, _) in
        if data != nil {
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]
                
                if let validJson = json {
                    print("JSON HERE \(validJson)")
                }
            } catch {
                print("Error parsing: \(error)")
            }
        }
        }.resume()
    
}

//GET request for a list of posts
/*
func getPlaceHolderRequest() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/")!
    
    //method requesting from API
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    //URL Session
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: request) {(data: Data?, _, error: Error?) in
        print("DATA HERE: \(data)")
        
        if error != nil {
            print("Error in url request: \(error)")
        }
        
        
        if data != nil {
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]
                
                if let validJson = json {
                    print("JSON HERE \(validJson)")
                    for weirdJson in validJson {
                        //PlaceholderPost(json: weirdJson)
                    }
                    
                }
            }
            catch {
                print("Error parsing: \(error)")
            }
        }
        }.resume()
}
*/
//Make POST? (creates and adds content)
func postPlaceHolderRequest() {
    let freddyMercurysURL = URL(string: "https://jsonplaceholder.typicode.com/posts/")!
    var bohemianRequest = URLRequest(url: freddyMercurysURL)
    bohemianRequest.httpMethod = "POST"
    
    //change this bicycleBody into data before making into a post?
    let bohemianBicycleBody: [String:Any] = [
        "userId": 5,
        "title": "Ride My Bicycle",
        "body": "I like to ride my bicycle, I like to ride my bike"
    ]
    
    do {
        let bohemianData = try JSONSerialization.data(withJSONObject: bohemianBicycleBody, options: [])
        bohemianRequest.httpBody = bohemianData
        
        print(bohemianData)
        
    } catch {
        print("Error creating the boehamian data: \(error)")
        //this error is given to any do/catch - not the same error in parameters in URL request
    }
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: bohemianRequest) {(data: Data?, _, bohemianError: Error?) in
        
        if bohemianError != nil {
            print(bohemianError!)
        }
        
        if data != nil {
            print(data!)
        }
        
        //another do catch? -> the response that you get back should post what you just created above
        do {
            let bohemianJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
            
            if let validJson = bohemianJson {
                print(validJson)
            }
            
        }
        catch {
            print("bohemian json error: \(error)")
        }
        }.resume()
}


//PUT (updates content) and DELETE placeholders
func putPlaceHolderRequest() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
    
   
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: urlRequest) {(data: Data?, _, error: Error?) in
        
        if error != nil {
            print(error!)
        }
        
        if data != nil {
            print(data!)
        }
        
        let body: [String:Any] = [
            "id": 1,
            "userId": 1,
            "title": "New Title",
            "body": "New Body"
        ]
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: [])
            urlRequest.httpBody = data
            
            print(data)
            
        } catch {
            print("Error creating the data: \(error)")
            //this error is given to any do/catch - not the same error in parameters in URL request
        }
        
        
        //another do catch? -> the response that you get back should post what you just created above
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
            
            if let validJson = json{
                print(validJson)
            }
            
        }
        catch {
            print("json error: \(error)")
        }
        }.resume()
    
}


//func deletePlaceHolderRequest() {}

/************************************************ for comments JSON placeholder API ********************/
//GET COMMENTS
func newRequestComments() {
    var getRequest = URLRequest(url: URL(string: "http://jsonplaceholder.typicode.com/comments/")!)
    getRequest.httpMethod = "GET"
    getRequest.addValue("application/json", forHTTPHeaderField: "Content-Type") // this API specifically asks that we pass this header key/value
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: getRequest) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        
        if error != nil { print(error!) }
        if urlResponse != nil { print(urlResponse!) }
        if data != nil {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                // be aware that casting a single post will fail, as the return type is [String : AnyObject]
                guard let parsedJson = jsonData as? [[String : AnyObject]] else {
                    print("ERROR attempting to cast Any to [[String:AnyObject]]")
                    return
                }
                
                var returnedPosts = [PlaceHolderComments]()
                for postJson in parsedJson {
                    if let newPost = PlaceHolderComments(json: postJson) {
                        returnedPosts.append(newPost)
                    }
                }
                        print(returnedPosts)
            }
            catch {
                print("error occured parsing: \(error)")
            }
        }
        }.resume()
    
}

func postComment() {

    var getRequest = URLRequest(url: URL(string: "http://jsonplaceholder.typicode.com/comments/")!)
    getRequest.httpMethod = "POST"
    getRequest.addValue("application/json", forHTTPHeaderField: "Content-Type") // this API specifically asks that we pass this header key/value
    
    let dict: [String:Any] = [
        "postId" : 1,
        "id" : 1,
        "name" : "Tom",
        "email": "blach",
        "body": "blachhh"
    ]
    
    do {
        let commentData = try JSONSerialization.data(withJSONObject: dict, options: [])
        getRequest.httpBody = commentData
    
    } catch {
        print("Error: \(error)")
    }
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: getRequest) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        
        if error != nil { print(error!) }
        if urlResponse != nil { print(urlResponse!) }
        if data != nil {
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let parsedJson = jsonData as? [String : Any] {
                    dump(parsedJson)
                    
                    let postObject = PlaceHolderComments(json: parsedJson)
                    dump(postObject)
                }
                
//                var returnedPosts = [PlaceHolderComments]()
//                for postJson in parsedJson {
//                    if let newPost = PlaceHolderComments(json: postJson) {
//                        returnedPosts.append(newPost)
//                    }
//                }
//                print(returnedPosts)
            }
            catch {
                print("error occured parsing: \(error)")
            }
        }
        }.resume()
}


//Can make one function to do multiple URL requests depending on common parameters
func makeCommentsRequests(commentId: Int = 1, endPoint: String, method: String = "GET", body: [String:Any]?, headers: [String:String]?) {}












//baselineURLSession()
//newRequest()
//getPlaceHolderRequest()
//postPlaceHolderRequest()
//newRequestComments()
postComment()


/**Both funcs prior are similar, what are the differences?**/
//depends on your APIs and data you are using
//newRequest has more specific headers or API calls (querires, or authorizations?)

PlaygroundPage.current.needsIndefiniteExecution = true
