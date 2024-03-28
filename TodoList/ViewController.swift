
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
        cell.textLabel?.text = datas[indexPath.row].title
        
        let switchView = UISwitch()
        switchView.isOn = datas[indexPath.row].isSwitchOn
        
    
        switchView.tag = indexPath.row
        
        switchView.addTarget(self, action: #selector(todoSwitch(_:)), for: .valueChanged)
     
        cell.accessoryView = switchView
        
        return cell
    
    }
    
    // TableViewCell의 스위치가 변경될 때 호출되는 메서드
    @objc func todoSwitch(_ sender: UISwitch) {
        datas[sender.tag].isSwitchOn = sender.isOn
        print("Switch changed for row \(sender.tag)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(datas[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

