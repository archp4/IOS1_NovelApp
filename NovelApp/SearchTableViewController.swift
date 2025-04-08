//
//  SearchTableViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import UIKit

class SearchTableViewController: UITableViewController, SearchNovelDelegate,UISearchBarDelegate {
    
    var indicator = UIActivityIndicatorView()
    var novels: [NovelDetail] = []
    @IBOutlet weak var searchBarIB: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarIB.delegate = self
        APIManager.shared.searchDelegate = self
        activityIndicator()
        indicator.backgroundColor = UIColor.white
    }
    
    func onNetworkError(errorMessage: String) {
        errorText(errorMessage: errorMessage)
    }
    
    func onDataRecieve(novels: [NovelDetail]) {
        self.novels = novels
        tableView.reloadData()
        errorTextView.isHidden=true
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        errorTextView.isHidden=true
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = CGPointMake(self.view.frame.size.width  / 2, self.view.frame.size.height / 2.40)
        self.view.addSubview(indicator)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NovelDataViewController
        {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            vc.novelURL = novels[index].href
        }
    }
    
    var errorTextView = UITextView()
    func errorText(errorMessage message:String){
        DispatchQueue.main.async {
            self.errorTextView.isHidden=false
            self.errorTextView.text = message
            self.errorTextView.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: self.view.frame.width, height: 40)
            self.errorTextView.center = CGPointMake(self.view.frame.size.width  / 2, self.view.frame.size.height / 2.40)
            self.errorTextView.textColor = UIColor.red
            self.errorTextView.textAlignment = NSTextAlignment.center
            self.view.addSubview(self.errorTextView)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestQuery()
    }
    
    func requestQuery(){
        let query = searchBarIB.text ?? ""
        if query.count > 3 {
            APIManager.shared.searchNovel(query: query)
            indicator.startAnimating()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestQuery()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return novels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTile", for: indexPath) 
        cell.textLabel?.text = novels[indexPath.row].name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
    */

}
