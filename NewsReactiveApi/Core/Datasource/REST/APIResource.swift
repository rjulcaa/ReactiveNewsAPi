//
//  APIResource.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/27/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


//Request through URLSession


class RestClient{
  func performRequest<T : Decodable>(url: ApiRouter,urlSession : URLSession, dataType: T.Type) -> Single<T> {
    return Single<T>.create {(singleEvent) -> Disposable in
      let disposable = Disposables.create()
      
      urlSession.dataTask(with: try! url.asURLRequest(), completionHandler: { (data, response, error) in
        guard let response = response else{
          singleEvent(.error(HttpError.ServerError(error: "Error con el servidor")))
          
          return
        }
        guard error == nil else {
          singleEvent(.error(HttpError.ServerError(error: error!.localizedDescription)))
          return
        }
        
        let httpResponse = response as! HTTPURLResponse
        if HTTPStatusCode.isSuccess(code: httpResponse.statusCode){
          guard let decodedData = try? JSONDecoder().decode(T.self, from: data!) else{
            singleEvent(.error(HttpError.dataSerializationError(error: "JSON object could not be serialized \(String(data: data!, encoding: .utf8)!)")))
            return
          }
          singleEvent(.success(decodedData))
        }else{
          guard let decodedError = try? JSONDecoder().decode(ServerError.self, from: data!) else{
            singleEvent(.error(HttpError.dataSerializationError(error: "JSON object could not be serialized \(String(data: data!, encoding: .utf8)!)")))
            return
          }
          
          singleEvent(.error(HttpError.ServerError(error: decodedError.message ?? "")))
        }
      }).resume()
      return disposable
    }
  }
}

struct ServerError:Codable{
  let status:String?
  let code:String?
  let message:String?
  
}




