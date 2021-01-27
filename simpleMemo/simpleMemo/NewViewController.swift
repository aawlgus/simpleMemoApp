//
//  NewViewController.swift
//  simpleMemo
//
//  Created by 정지현 on 2021/01/07.
//

import UIKit

class NewViewController: UIViewController, UITextViewDelegate {
    
    // var saveBtnClicked: Bool = false
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func done(_ sender: Any) {
        self.memoTextView.resignFirstResponder()
        guard let memo = memoTextView.text,
              memo.count > 0 else {
            alert(message: "Create a new memo")
            return
        }
        //dismiss(animated: true, completion: nil)
        // self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.memoTextView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            guard let memo = memoTextView.text,
                  memo.count > 0 else {
                //alert(message: "메모를 입력하세요")
                return
            }
            print(memo.count)
            print(#function)
            let newMemo = Memo(content: memo, insertDate: Date())
            Memo.dummyMemoList.append(newMemo)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.memoTextView.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
