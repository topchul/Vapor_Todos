import Fluent
import Vapor

func routes(_ app: Application) throws {
    let todoController = TodoController()
    app.post("todos", use: todoController.create)
    app.get("todos", use: todoController.readAll)
    app.get("todos", ":id", use: todoController.read)
    app.post("todos", ":id", use: todoController.update)
    app.delete("todos", ":id", use: todoController.delete)
    
//    app.get("todos", use: todoController.index)
//    app.delete("todos", ":todoID", use: todoController.delete)
}
