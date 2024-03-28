//
//  ViewController.swift
//  TodoList
//
//  Created by 서혜림 on 3/28/24.
//
//
//import UIKit
//
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let datas = ["todo 1", "todo 2", "todo 3" ]
//
//    @IBAction func addTodoButton(_ sender: Any) {
//        let title = "iTunes Store에 로그인"
//        let message="사용자의 Apple ID exDex.com의 암호를 입력하세요"
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
//        //확인을 클릭했을때 처리할 내용
//        }
//        alert.addAction(cancel)
//        alert.addAction(ok)
//        self.present(alert, animated: true)
//
//        alert.addTextField() { (tf) in
//            tf.placeholder = "할 일을 입력하세요."
//            tf.isSecureTextEntry = false
//        }
//    }
//
//    func setUITableView() {
//
//        let tableView = UITableView()
//        tableView.frame = self.view.bounds
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//
//        self.view.addSubview(tableView)
//    }
//
//    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datas.count
//    }
//
//    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = datas[indexPath.row]
//        return cell
//    }
//
//    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print ("Selected: \(datas[indexPath.row])")
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}

// MARK: - fix
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let datas = ["todo 1", "todo 2", "todo 3" ]
    
    @IBOutlet weak var todolisTableView: UITableView!
    
    @IBAction func todoSwitch(_ sender: UISwitch) {
        }
   
    func setupSwitch() {
        let mySwitch = UISwitch()
        mySwitch.isOn = true
        mySwitch.onTintColor = UIColor.green
        mySwitch.thumbTintColor = UIColor.white
        mySwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        mySwitch.frame = CGRect(x: 150, y: 200, width: 100, height: 100)
        self.view.addSubview(mySwitch)
    }

   
    @IBAction func addTodoButton(_ sender: Any) {
        let title = "할 일 추가"
        let message="할 일들을 입력하세요."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "추가", style: .default) { (_) in
            //확인을 클릭했을때 처리할 내용
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
        alert.addTextField() { (tf) in
            tf.placeholder = "할 일을 입력하세요."
            tf.isSecureTextEntry = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitch()
        todolisTableView.dataSource = self
        todolisTableView.delegate = self // delegate 설정도 추가
        todolisTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Selected: \(datas[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
