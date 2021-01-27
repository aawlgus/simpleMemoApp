//
//  MemoListTableViewController.swift
//  simpleMemo
//
//  Created by 정지현 on 2021/01/06.
//

import UIKit

class MemoListTableViewController: UITableViewController, UISearchBarDelegate {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    } ()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMemo = [Memo]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Search Controller 셋업
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Memo"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func sort(_ sender: Any) {
        Memo.dummyMemoList.sort(by: { $0.insertDate > $1.insertDate})
        viewWillAppear(true)
        viewDidAppear(true)
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredMemo.count
        }
        return Memo.dummyMemoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target: Memo
        if isFiltering() {
            target = filteredMemo[indexPath.row]
        } else {
            target = Memo.dummyMemoList[indexPath.row]
        }
        //let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Alert", message: "This memo will be deleted.", preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Delete", style: .default, handler: {_ in
                if self.isFiltering() {
                    let filteredContent = self.filteredMemo[indexPath.row]
                    guard let actualRow = Memo.dummyMemoList.firstIndex(of: filteredContent) else {
                        return
                    }
                    Memo.dummyMemoList.remove(at: actualRow)
                    self.filteredMemo.remove(at: indexPath.row)
                } else {
                    Memo.dummyMemoList.remove(at: indexPath.row)
                }
                //Memo.dummyMemoList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            } )
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            /*
            deleteAlert(message: "This memo will be deleted.")
            Memo.dummyMemoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
 */
        }
    }
    // ResultViewController에 값 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // 목적지 뷰 컨트롤러 인스턴스 읽어오기
            if let dest = segue.destination as? ResultViewController {
                // 값 전달
                if isFiltering() {
                    dest.memo = filteredMemo[indexPath.row]
                    dest.row = indexPath.row
                } else {
                    dest.memo = Memo.dummyMemoList[indexPath.row]
                    dest.row = indexPath.row
                }
                //dest.memo = Memo.dummyMemoList[indexPath.row]
                //dest.row = indexPath.row
            }
        }
    }
    
    // searchBar instance methods
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMemo = Memo.dummyMemoList.filter({( memo : Memo) -> Bool in
        return memo.content.lowercased().contains(searchText.lowercased())
      })

      tableView.reloadData()
    }
    // 현재 필터링된 정보를 사용하는지 여부
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }

}

// 사용자가 검색창에 입력한 정보 기반으로 결과 업데이트하는 방법 정의
extension MemoListTableViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
