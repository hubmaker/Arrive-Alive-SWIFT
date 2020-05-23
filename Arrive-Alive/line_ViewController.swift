//
//  Line_ViewController.swift
//  Arrive-Alive
//
//  Created by pjh on 2020/05/23.
//  Copyright © 2020 COMP420. All rights reserved.
//

import UIKit
import Foundation

class Line_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var line = ["1호선", "2호선", "3호선"]
    var selectRow = 0
    
    @IBOutlet weak var line_picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        line_picker.delegate = self
        line_picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return line.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectRow = row
        return line[row]
    }
    @IBAction func initial_nextButton(_ sender: Any) {
        let ad = UIApplication.shared.delegate as? AppDelegate
        ad?.paramLine = line[selectRow]
        self.presentingViewController?.dismiss(animated: true)
        
        //line[selectRow] 에 몇 호선인지 들어있음 -> 서버로 보내는 값

        
        //var get_station 에 호선에 해당하는 역들이 들어옴 -> 서버에서 받아오는 값
        //ad?.paramStation = get_station.split(separator: "@")
        ad?.paramStation = ["형진역", "주홍역", "효상역", "영욱역"]
        
    }
}
