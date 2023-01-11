//
//  ViewController.swift
//  Jan-03-URLSession_DataTask
//
//  Created by Admin on 3/1/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
//        postData()
    }
    
    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("\(error.localizedDescription) is happened!!")
            }
            else {
                guard let data = data else { return }
                MyData.dataList = try! JSONDecoder().decode([MyData].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
//                for i in 0..<myData.count {
//                    print("Title: \(myData[i].title)")
//                }
            }
        }.resume()
    }
    
    func postData() {
        let param = [
            "title" : "Hello BJIT Academy",
            "body" : "This is awesome training academy."
        ]
        
        let newEncodeData = MyData(id: 123, title: "New title", body: "This is encodable data!")
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: param)
        request.httpBody = try? JSONEncoder().encode(newEncodeData)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription) happened!!")
            }
            else {
                guard let data = data else {
                    return
                }
                let myData = try? JSONDecoder().decode(MyData.self, from: data)
                print("The title is: \(myData?.title)")
            }
        }.resume()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyData.dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempOne", for: indexPath) as! customTVC

        cell.titleLabel.text = MyData.dataList[indexPath.row].title
        cell.detailsLabel.text = MyData.dataList[indexPath.row].body
        
        return cell
    }
}

