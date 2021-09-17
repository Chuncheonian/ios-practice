//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    // MARK:- Instance
    var calculatorBrain = CalculatorBrain()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK:- IBAction
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = "\(String(format: "%.0f", sender.value))Kg"
    }

    @IBAction func computePressed(_ sender: UIButton) {
        let height: Float = heightSlider.value
        let weight: Float = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
    
        self.performSegue(withIdentifier: "goToResult", sender: self)
    
    }
    
    // MARK:- Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            // as!를 사용함으로써 UIViewController을 ResultsViewController로 downcasting을 하였다.
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}
