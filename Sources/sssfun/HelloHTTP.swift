//
//  HelloHTTP.swift
//  sssfun
//
//  Created by nhatlee on 3/30/18.
//

import Foundation
import HTTP
import cows

//func hello(request: HTTPRequest, response: HTTPResponseWriter) -> HTTPBodyProcessing
//{
//    response.writeHeader(status: .ok, headers: [ "Content-Type": "text/html" ])
//    response.writeBody(
//        """
//        <h1>cows</h1>
//        <center><pre>\(vaca().htmlEscaped)</pre></center>
//        """
//    )
//    response.done()
//    return .discardBody
//}

func hello(request: HTTPRequest, response: HTTPResponseWriter )
    -> HTTPBodyProcessing
{
    let q   = request[query: "q"]?.lowercased() ?? ""
    let cow = q.isEmpty
        ? vaca() // random cow
        : allCows.first(where: { $0.lowercased().contains(q) })
        ?? "No such cow"
    
    response.writeHeader(status: .ok,
                         headers: [ "Content-Type": "text/html" ])
    response.writeBody(
        """
        <center>
        <form action="/hello/" method="get">
        Find Beef: <input name="q" placeholder="e.g. 'moon'">
        <a href="/hello/">[random]</a>
        </form>
        <pre>\(cow.htmlEscaped)</pre>
        </center>
        """
    )
    response.done()
    return .discardBody
}

// That can be put into a separate Helpers.swift file:

extension HTTPRequest {
    
    subscript(query q: String) -> String? {
        return URLComponents(string: target)?.queryItems?
            .first(where: { $0.name == q })?.value
    }
}

extension String {
    var htmlEscaped : String {
        let escapeMap : [ Character : String ] = [
            "<" : "&lt;", ">": "&gt;", "&": "&amp;", "\"": "&quot;"
        ]
        return map { escapeMap[$0] ?? String($0) }.reduce("", +)
    }
}
