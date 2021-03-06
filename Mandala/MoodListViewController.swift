//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Saber on 14/02/2021.
//

import UIKit

class MoodLisViewController: UITableViewController{
    var moodEntries: [MoodEntry] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        let dateString = DateFormatter.localizedString(from: moodEntry.timeStamp, dateStyle: .medium, timeStyle: .short)
        cell.detailTextLabel?.text = dateString
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            moodEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
}
extension MoodLisViewController: MoodsConfigurable{
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.insertRows(at:[IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
