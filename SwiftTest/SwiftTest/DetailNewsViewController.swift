//
//  DetailNewsViewController.swift
//  SwiftTest
//
//  Created by Ranjan on 18/07/18.
//  Copyright © 2018 Ranjan. All rights reserved.
//

import UIKit

class NyNewsCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
}

class DetailNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedName: NewsModal!
    @IBOutlet weak var back: UIButton!
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.dismiss(animated: true) {
           // self.delegate!.dismissViewController()
        }
        
    }
    @IBOutlet weak var detailCell: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNewsCell", for: indexPath as IndexPath) as! NyNewsCell
        cell.mainLabel.text = ""
        if 0 == indexPath.row ,let x = self.selectedName.mainHeadline {
             cell.mainLabel.text = x
        }
        else if 1 == indexPath.row, let x = self.selectedName.subHeadline{
            cell.mainLabel.text = x
        }
        else if 2 == indexPath.row, let x = self.selectedName.author{
            cell.mainLabel.text = x
        }
        else if 3 == indexPath.row,let x = self.selectedName.date
        {
            cell.mainLabel.text = x
        }
        else
        {
            cell.mainLabel.text = ""
        }
    
        
    
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    

}
