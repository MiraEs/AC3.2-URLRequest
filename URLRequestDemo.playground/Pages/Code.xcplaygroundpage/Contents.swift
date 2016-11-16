import Foundation
import PlaygroundSupport


protocol JSONable {
    init?(json: [String: Any])
    func toJson() -> [String:Any]
}



//Added equatable protcol to compare these diff properties in this struct
//struct PlaceholderPost: Equaltable
// different types of PROTOCOLS available here
struct PlaceholderPost: JSONable {
    //1. what values needed to return for posts (Postman)
    //2. create the instance vars
    //3. parse out into 100 Placeholders (in func - create an array)
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    
    init?(json: [String : Any]) {
        if let juserId = json["userId"] as? Int,
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let body = json["body"] as? String {
            self.id = id
            self.title = title
            self.body = body
        } else {
            return nil
        }
        
        
        
        //function to turn code back into Json Dict??
        func toJson() -> [String : Any] {
            let jsonLiteralDict: [String: Any] = [
                "userId": self.userId,
                "id": self.id,
                "title": self.title,
                "body": self.body
            ]
            PlaceholderPost(json: jsonLiteralDict)
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
                        PlaceholderPost(json: weirdJson)
                    }
                    
                }
            }
            catch {
                print("Error parsing: \(error)")
            }
        }
        }.resume()
}

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
    let freddyMercurysURL = URL(string: "https://jsonplaceholder.typicode.com/posts/")!
    var bohemianRequest = URLRequest(url: freddyMercurysURL)
    bohemianRequest.httpMethod = "POST"
    
    //change this bicycleBody into data before making into a post?
    let bohemianBicycleBody: [String:Any] = [
        "userId": 5,
        "title": "Ride My Bicycle",
        "body": "I like to ride my bicycle, I like to ride my bike sometimes"
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


//func deletePlaceHolderRequest() {}












//baselineURLSession()
//newRequest()
//getPlaceHolderRequest()
//postPlaceHolderRequest()



/**Both funcs prior are similar, what are the differences?**/
//depends on your APIs and data you are using
//newRequest has more specific headers or API calls (querires, or authorizations?)

PlaygroundPage.current.needsIndefiniteExecution = true
