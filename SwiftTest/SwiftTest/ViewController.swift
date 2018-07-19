//
//  ViewController.swift
//  SwiftTest
//
//  Created by Ranjan on 25/12/17.
//  Copyright © 2017 Ranjan. All rights reserved.
//

import UIKit

let productKey = "ABC"
let url = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=d84bea1f0a9d42378053ccd767456b83"

//key in Json
let mainHeadingKey = "title"
let subHeadingKey = "abstract"
let authorKey  = "byline"
let publishDateKey = "published_date"

class NyViewCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var roundRect: UIView!
    @IBOutlet weak var calendarImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    func setUpCell(_ newsObject:NewsModal)
    {
        self.mainLabel?.text = newsObject.mainHeadline
        self.subLabel.text = newsObject.subHeadline
        self.authorLabel.text = newsObject.author
        self.dateLabel.text = newsObject.date
        self.roundRect.layer.cornerRadius =
        self.roundRect.frame.height/2.0
        self.roundRect.backgroundColor = UIColor.lightGray

    }
    
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listView: UITableView!
    var newsCollection = [NewsModal]()
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        
        // Set Center
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        activityIndicatorView.startAnimating()
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            // Handle result
            DispatchQueue.main.async() {
                // stop animator UI update code
                self.activityIndicatorView.stopAnimating()
            }
            
            guard let resp = response else {
                //show("response does not come properly")
                return
            }
            print(resp)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let results = json["results"] as! [AnyObject]
                var i  = 1
               // while( i != 10){
                for dic in results {

                    let newDic = dic as! Dictionary<String, AnyObject>
                    let news = NewsModal.init(mainHeadline: newDic[mainHeadingKey] as? String,subHeadline: newDic[subHeadingKey] as? String, author: newDic[authorKey] as? String, date: newDic[publishDateKey] as? String)

                    self.newsCollection.append(news)
                    i = i + 1;
                    
                }
                DispatchQueue.main.async() {
                    // update List view data code
                    self.listView.reloadData()
                }
                

                
                print(json)
            } catch {
                print("error")
            }

            }.resume()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYCellDemo", for: indexPath as IndexPath) as! NyViewCell
        
        let newsObject = newsCollection[indexPath.row]
        cell.setUpCell(newsObject)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsCollection.count
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailNewsViewController
        next.selectedName = newsCollection[indexPath.row]
        self.present(next, animated: true, completion: nil)
    }
    

    
}

