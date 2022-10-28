//
//  Client.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-06.
//

import Foundation
import Alamofire
import Defaults
import KeychainAccess


//let token = "eyJhbGciOiJSUzUxMiJ9.eyJzdWIiOiIzUEtleWUzSmp3aGwiLCJhdWQiOiJjaXJjbGV0LXdlYi11aSIsIm9yZ0RvbWFpbiI6InN0cmVldHR1cnRsZSIsIm5hbWUiOiJzdHJlZXR0dXJ0bGUiLCJpc3MiOiJodHRwczpcL1wvc3RyZWV0dHVydGxlLmpldGJyYWlucy5zcGFjZSIsInBlcm1fdG9rZW4iOiJOZlRhUzF5S2gwdiIsInByaW5jaXBhbF90eXBlIjoiVVNFUiIsImlhdCI6MTY2NTEwOTA2MX0.QUES1eajVtqmdcJkU4In7qymNqFHXhNNrAxPMPd8rJAoAJbHVutc5FSV4tnzvJ3wibr8RJBUpIz3Q9p6ZBlP_AkpguN_VTbb2ytyLRIXCt8PAcdojI223lWMrlXs6DsARuUFJV1Qu2zmTQwhFRqGsd127gGMo5ESnx6apKIfxn8"

public class SpaceClient {
    @Default(.orgName) var orgName
    @Default(.projectId) var projectId
    @FromKeychain(.token) var token
    
    func getTodos(completion:@escaping (([TodoItemRecord]) -> Void)) -> Void {
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/todo", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<TodoItemRecord>.self) { response in
                switch response.result {
                case .success(let resp):
                    print("get todos")
                    completion(resp.data)
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion([TodoItemRecord]())
                    print(response.debugDescription)
                }
            }
    }
    
    func createTodo(text: String, completion:@escaping (() -> Void)) -> Void {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        let parameters = [
            "text": text
                ] as [String: Any]
        AF.request("https://\(orgName).jetbrains.space/api/http/todo", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TodoItemRecord.self) { response in
                switch response.result {
                case .success(let resp):
                    completion()
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion()
                    print(response.debugDescription)
                }
            }
    }
    
    func deleteTodo(id: String, completion:@escaping (() -> Void)) -> Void {
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/todo/\(id)", method: .delete, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<TodoItemRecord>.self) { response in
                switch response.result {
                case .success(let resp):
                    completion()
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion()
                    print(response.debugDescription)
                }
            }
    }

    func toggleTodoStatus(todo: TodoItemRecord, completion:@escaping (() -> Void)) -> Void {
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        let parameters = [
            "open": "\(todo._status != "Open")",
                ] as [String: Any]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/todo/\(todo.id)", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<TodoItemRecord>.self) { response in
                switch response.result {
                case .success(let resp):
                    completion()
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion()
                    print(response.debugDescription)
                }
            }
    }
    
    
    func getIssues(statusId: String = "", type: String = "", completion:@escaping (([Issue]) -> Void)) -> Void {
        NSLog("Getting Issues")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        var url = "https://\(orgName).jetbrains.space/api/http/projects/\(projectId)/planning/issues?sorting=UPDATED&descending=true"
        
        if !statusId.isEmpty {
            url += "&statuses=\(statusId)"
        }
        
        if type == "assigned" {
            url += "&assigneeId=me"
        } else if type == "created" {
            url += "&createdByProfileId=me"
        }
        print(url)
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<Issue>.self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp.data)
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion([Issue]())
                    print(response.debugDescription)
                }
            }
    }
    
    
    func getIssueStatuses(completion:@escaping (([IssueStatus]) -> Void)) -> Void {
        NSLog("Getting Issue Statuses")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/projects/\(projectId)/planning/issues/statuses", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [IssueStatus].self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([IssueStatus]())
                    print(response.debugDescription)
                }
            }
    }
    
    func updateIssueStatus(issueId: String, newStatusId: String, completion:@escaping (() -> Void)) -> Void {
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        let parameters = [
            "status": newStatusId,
                ] as [String: Any]
//        /api/http/projects/{project}/planning/issues/{issueId}
        AF.request("https://\(orgName).jetbrains.space/api/http/projects/\(projectId)/planning/issues/\(issueId)", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: String.self) { response in
                switch response.result {
                case .success(let resp):
                    completion()
                case .failure(let error):
//                    sendNotification(body: error.localizedDescription)
                    completion()
//                    print(response.debugDescription)
                }
            }
    }
    
    func getCodeReviews(completion:@escaping (([String]) -> Void)) -> Void {
        NSLog("Getting Code Reviews")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/projects/\(projectId)/code-reviews?sorting=UPDATED&descending=true&author=me", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<CodeReviewWithCount>.self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp.data.map{ r in r.review.id})
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([String]())
                    print(response.debugDescription)
                }
            }
    }
    
    func getCodeReview(id: String, completion:@escaping ((CodeReviewRecord?) -> Void)) -> Void {
        NSLog("Getting Code Review by id \(id)")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/projects/\(projectId)/code-reviews/\(id)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CodeReviewRecord.self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                    print(response.debugDescription)
                }
            }
    }
    
    func getProjects(completion:@escaping (([Project]) -> Void)) -> Void {
        NSLog("Getting Projects")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
                
        AF.request("https://\(orgName).jetbrains.space/api/http/projects", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Resp<Project>.self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp.data)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([Project]())
                    print(response.debugDescription)
                }
            }
    }
    
    func getProjectById(id: String, completion:@escaping ((Project?) -> Void)) -> Void {
        NSLog("Getting Project by id: \(id)")
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request("https://\(orgName).jetbrains.space/api/http/projects/\(id)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Project.self) { response in
                switch response.result {
                case .success(let resp):
                    completion(resp)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                    print(response.debugDescription)
                }
            }
    }
    
}
