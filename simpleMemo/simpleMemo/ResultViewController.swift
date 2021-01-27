//
//  ResultViewController.swift
//  simpleMemo
//
//  Created by 정지현 on 2021/01/10.
//

import UIKit

class ResultViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet var resultMemo: UITextView!
    var memo: Memo? // 값을 받을 변수
    var row: Int? // row 값을 받을 변수
    
    
    @IBAction func share(_ sender: Any) {
        guard let memo = memo?.content else {return}
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultMemo.delegate = self
        self.resultMemo.text = memo?.content
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            guard let nmemo = resultMemo.text,
                  nmemo.count > 0 else {
                return
            }
            //print("memo:", memo?.content)
            let newMemo = Memo(content: nmemo, insertDate: Date())
            //print("newMemo:", newMemo.content)
            if newMemo.content != memo?.content {
                Memo.dummyMemoList.append(newMemo)
                Memo.dummyMemoList.remove(at: row!)
            } else {
                print("same content")
            }
            //Memo.dummyMemoList.append(newMemo)
            //Memo.dummyMemoList.remove(at: row!)
        }
    }
    
    
    func textViewDidBeginEditing(resultMemo: UITextView) {
        if resultMemo.tag == 1 {
            print("result selected")
            return
        }
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
