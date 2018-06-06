import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, response) in
    response.setBody(string: "Hello, Perfect!").completed()
}

func returnJSONMessage(message: String, response: HTTPResponse) {
    do{
        try response
            .setBody(json: ["message": message])
            .setHeader(.contentType, value: "application/json")
            .completed()
    }catch{
        response
            .setBody(string: "Error handling request: \(error)")
            .completed(status: .internalServerError)
    }
}

routes.add(method: .get, uri: "/hello") { (request, response) in
    returnJSONMessage(message: "Hello, JSON!", response: response)
}

routes.add(method: .get, uri: "/hello/there") { (request, response) in
    returnJSONMessage(message: "I am tired of saying Hello!", response: response)
}

//With the url variable
routes.add(method: .get, uri: "/beers/{num_beer}") { (request, response) in
    guard let numBeerString = request.urlVariables["num_beer"], let numBeerInt = Int(numBeerString) else{
        response.completed(status: .badRequest)
        return
    }
    returnJSONMessage(message: "Take beer num \(numBeerInt)", response: response)
}

//POST Method:  localhost:8080/post?name=mia
routes.add(method: .post, uri: "post") { (request, response) in
    guard let name = request.param(name: "name")else{
        response.completed(status: .badRequest)
        return
    }
    returnJSONMessage(message: "hello: \(name)", response: response)
}


server.addRoutes(routes)

do{
    try server.start()
}catch PerfectError.networkError(let err, let msg){
    print("Network error throws \(err) \(msg)")
}


