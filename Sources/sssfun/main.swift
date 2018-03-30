import HTTP
import Foundation
let server = HTTPServer()
do {
    try server.start(port: 1337, handler: hello)
}
catch {
    print("failed to start server:", error)
    exit(42)
}

RunLoop.current.run()
