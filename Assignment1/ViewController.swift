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

    }



}



extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "dogsCustomcellIdentifier", for: indexPath) as! CustomCell
        

        return cell

    }

}

