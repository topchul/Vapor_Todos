import Fluent
import SQLKit
import SQLite3
import Vapor

struct TodoController {
//    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
//        return Todo.query(on: req.db).all()
//    }
//
//    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//        return Todo.find(req.parameters.get("todoID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap { $0.delete(on: req.db) }
//            .transform(to: .ok)
//    }
    
    /*
        curl -i -X POST "http://localhost:8080/todos" \
          -H "Content-Type: application/json" \
          -d '{"title": "Hello World!"}'
     */
    func create(req: Request) throws -> EventLoopFuture<Todo.Output> {
        let input = try req.content.decode(Todo.Input.self)
        let todo = Todo(title: input.title)
        return todo.save(on: req.db)
            .map { Todo.Output(id: todo.id!.uuidString, title: todo.title) }
    }
    
    /*
        curl -i -X GET "http://localhost:8080/todos?page=2&per=2" \
          -H "Content-Type: application/json"
     */
    func readAll(req: Request) throws -> EventLoopFuture<Page<Todo.Output>> {
        let corp_code = "00126380" // 삼성전자
//        let corp_code = "00540447" // 유니테스트
        
        let client = DartClient()
        
        DispatchQueue.global().async {
            //
            // * CoreCode 정리
//            let corpCodes = client.getCorpCode()
//            corpCodes.forEach {
//                _ = $0.saveIfNotExists(on: req.db)
//                print(".", terminator: "")
//            }
            
            //
            // * 기업개황 조회
            let company: Company
            let companyFuture = Company.company(forCorpCode: corp_code, on: req.db)
            if let dbCompany = try? companyFuture.wait() {
                // 이전에 획득한 정보를 활용할 것이므로 암것도 안한다.
                print(corp_code, "[Company] alreay get")
                company = dbCompany
                
            } else if let webCompany = client.getCompany(corp_code: corp_code) {
                // 웹조회 결과를 저장하자.
                _ = webCompany.saveIfNotExists(on: req.db)
                print(corp_code, "[Company] will save that load from web")
                company = webCompany
                
            } else {
                // 웹조회에 실패했으니 끝났다.
                print(corp_code, "[Company] fail to load from web")
                return
                
            }
            print("*******\nCompany\n*******",
                  "\n\(company)\n\n")
            
            //
            // * 보고서 목록 조회
            let listItems: [ListItem]
            let maxRceptDt = ListItem.maxRceptDt(forCorpCode: corp_code, on: req.db)
            if let maxRceptDt = try? maxRceptDt.wait(),
                DartController.existsReportIn3Months(rceptDt: maxRceptDt) {
                // 이전에 획득한 정보를 활용할 것이므로 암것도 안한다.
                print(corp_code, "[Report Item] alreay get")
                
                let gregorian = Calendar(identifier: .gregorian)
                let bgn_year = gregorian.component(.year, from: gregorian.date(byAdding: .year, value: -3, to: Date())!)
                let end_year = gregorian.component(.year, from: gregorian.date(byAdding: .day, value: 1, to: Date())!)
                
                listItems = try! ListItem.listItems(forCorpCode: corp_code, fromRceptDt: "\(bgn_year)0101", toRceptDt: "\(end_year)1231", on: req.db)
                    .wait()
                
            } else if let webListItems = client.getListItems(corp_code: corp_code) {
                // 웹조회 결과를 저장하자.
                webListItems.forEach {
                    _ = $0.saveIfNotExists(on: req.db)
                }
                print(corp_code, "[Report Item] will save that load from web")
                listItems = webListItems

            } else {
                // 웹조회에 실패했으니 끝났다.
                print(corp_code, "[Report Item] fail to load from web")
                return
                
            }
            print("*******\nReports\n*******",
                  "\n\(listItems.map({ "\($0.corp_code).\($0.rcept_no).\($0.dcm_no ?? "<nil dcm>").\($0.report_nm)" }).joined(separator: "\n") as NSString)\n\n")
            
            print("*******\nDetail Reports\n*******")
            let last4QuarterItems = listItems[max(0, listItems.count - 4)..<listItems.count]
            
            last4QuarterItems.forEach { item in
                print("* \(item.corp_code).\(item.rcept_no).\(item.dcm_no ?? "<nil dcm>").\(item.report_nm) *")
                client.getDoucment(rceptNo: item.rcept_no, dcmNo: item.dcm_no!, modified: item.modified)
            }
            
        }
                
        return Todo.query(on: req.db).paginate(for: req).map { page in
            page.map { Todo.Output(id: $0.id!.uuidString, title: $0.title) }
        }
    }
    
    /*
        curl -i -X GET "http://localhost:8080/todos/<id>" \
          -H "Content-Type: application/json"
     */
    func read(req: Request) throws -> EventLoopFuture<Todo.Output> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Todo.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { Todo.Output(id: $0.id!.uuidString, title: $0.title) }
    }
    
    /*
        curl -i -X POST "http://localhost:8080/todos/<id>" \
          -H "Content-Type: application/json" \
          -d '{"title": "How are you?"}'
     */
    func update(req: Request) throws -> EventLoopFuture<Todo.Output> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Todo.Input.self)
        return Todo.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { todo in
                todo.title = input.title
                return todo.save(on: req.db)
                    .map { Todo.Output(id: todo.id!.uuidString, title: todo.title) }
        }
    }
    
    /*
        curl -i -X DELETE "http://localhost:8080/todos/<id>"
     */
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Todo
            .find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
