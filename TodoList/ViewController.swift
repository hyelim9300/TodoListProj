import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct TodoItem {
        var title: String
        var isSwitchOn: Bool
    }
    
    var datas: [TodoItem] = [
        TodoItem(title: "todo 1", isSwitchOn: false),
        TodoItem(title: "todo 2", isSwitchOn: false),
        TodoItem(title: "todo 3", isSwitchOn: false)
    ]
    
    @IBOutlet weak var todoListTableViewCell: UITableView!
    
    @IBAction func addTodoButton(_ sender: Any) {
        let title = "할 일 추가"
        let message = "할 일을 입력하세요."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "추가", style: .default) { (_) in
            if let newTodoTitle = alert.textFields?.first?.text {
                self.addTodoItem(title: newTodoTitle)
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField() { (tf) in
            tf.placeholder = "할 일을 입력하세요."
            tf.isSecureTextEntry = false
        }
        self.present(alert, animated: true)
    }
    
    func addTodoItem(title: String) {
        let newTodo = TodoItem(title: title, isSwitchOn: false)
        datas.append(newTodo)
        todoListTableViewCell.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListTableViewCell.dataSource = self
        todoListTableViewCell.delegate = self
        todoListTableViewCell.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todoItem = datas[indexPath.row]
        
        let attributeString = NSMutableAttributedString(string: todoItem.title)
        if todoItem.isSwitchOn {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        cell.textLabel?.attributedText = attributeString
        
        let switchView = UISwitch()
        switchView.isOn = todoItem.isSwitchOn
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(todoSwitch(_:)), for: .valueChanged)
        
        cell.accessoryView = switchView
        
        return cell
    }

    @objc func todoSwitch(_ sender: UISwitch) {
        datas[sender.tag].isSwitchOn = sender.isOn
        todoListTableViewCell.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(datas[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datas.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

