//
//  LocalNovelTableViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-11.
//

import UIKit

class LocalNovelTableViewController: UITableViewController {
    
    var localModel : [NovelEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocalModel()
    }
    
    func updateLocalModel(){
        localModel = LocalNovelManager.shared.getChapters()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "localNovelListTile", for: indexPath) as! LocalNovelTableViewCell
        cell.ChapterNameTitle.text = localModel[indexPath.row].chapterName
        print(localModel[indexPath.row].chapterName!)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Segued")
        if let vc = segue.destination as? LocalNovelViewController
        {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            vc.LocalChapter = localModel[index]
        }
    }

}
