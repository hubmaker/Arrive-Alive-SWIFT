//
//  End_ViewController.swift
//  Arrive-Alive
//
//  Created by pjh on 2020/05/23.
//  Copyright © 2020 COMP420. All rights reserved.
//

import UIKit

class End_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let ad = UIApplication.shared.delegate as? AppDelegate
    var end = [""]
    override func viewWillAppear(_ animated: Bool) {
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let get_station = ad?.paramStation {
            end = get_station
        }
        
        if let get_start = ad?.paramStart {
            end = end.filter(){$0 != get_start}
        }
    }
    
    var selectRow = 0
    
    @IBOutlet weak var end_picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        end_picker.delegate = self
        end_picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return end.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectRow = row
        return end[row]
    }
    
    
    @IBAction func end_alarmButton(_ sender: Any) {
        ad?.paramEnd = end[selectRow]
        self.presentingViewController?.dismiss(animated: true)
        
        var send_value_array = ["", "", ""]
        if let get_line = ad?.paramLine {
            send_value_array[0] = get_line
        }
        
        if let get_start = ad?.paramStart {
            send_value_array[1] = get_start
        }
        
        if let get_end = ad?.paramEnd {
            send_value_array[2] = get_end
        }
        var send_data = send_value_array.joined(separator : "@")
        print(send_data)
    }
}
