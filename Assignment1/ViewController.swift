//
//  AppDelegate.swift
//  Assignment1
//
//  Created by
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
// Balaji Chandupatla
//
import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var dogsListTableView: UITableView!
    private var dogslist = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogsListTableView.rowHeight = 44
        getListOfDogs()
    }
    
    func getListOfDogs() {
        fetchDogsListFromApiService { [weak self] (dogs) in
            if let dogsList: [String:[String]] = dogs?.message {
                for (name,breedArray) in Array(dogsList).sorted(by: {$0.0 < $1.0}) {
                    let dog = NSMutableDictionary()
                    dog.setValue(name, forKey: "name")
                    dog.setValue(breedArray, forKey: "breedName")
                    self?.dogslist.add(dog)
                }
        
                DispatchQueue.main.async {
                    self?.dogsListTableView.reloadData()
                }
            }
        }
    }

    func fetchDogsListFromApiService(completionHandler: @escaping (Dogs?) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching dogs: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }

          if let data = data,
            let dogsList = try? JSONDecoder().decode(Dogs.self, from: data) {
              completionHandler(dogsList)
          }
        })
        task.resume()
      }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogsCustomcellIdentifier", for: indexPath) as! CustomCell
        cell.dogsSubBreedsLabel.isHidden = true
        if let dictDog = dogslist[indexPath.row] as? NSMutableDictionary {
            if let dogName = dictDog.value(forKey: "name") as? String {
                cell.dogsNameLabel.text = dogName
            }
            if let dogSubBreed = dictDog.value(forKey: "breedName") as? [String], dogSubBreed.count > 0 {
                cell.dogsSubBreedsLabel.isHidden = false
                let combineTheText = dogSubBreed.joined(separator: ",")
                cell.dogsSubBreedsLabel.text = ": \(combineTheText)"
            }
        }
        
        return cell
    }
}

struct Dogs: Codable {
    let message: [String: [String]]?
    let status: String?
}

extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)];
        }
    }
}
