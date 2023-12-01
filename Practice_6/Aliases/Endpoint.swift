//
//  Endpoint.swift
//  customNetworking
//
//

protocol Endpoint {
    var compositePath: String { get }
    var headers: HeaderModel { get }
}
