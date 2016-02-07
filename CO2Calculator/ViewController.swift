//
//  ViewController.swift
//  CO2Calculator
//
//  Created by LEE  SEIKAI on 2016/01/11.
//  Copyright © 2016年 SHL Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var screenHeight: CGFloat!
    var screenWidth:  CGFloat!
    var statusBarHeight:CGFloat!
    let goldenProportion:CGFloat = 1/1.618
    
    //テキストエリアの位置
    var panelFrame:CGRect!
    //CO2ボタン
    var co2ButtonMargin:CGFloat!
    var co2ButtonWidth:CGFloat!
    var co2ButtonHeight:CGFloat!
    //計算ボタン
    var calculateButtonMargin:CGFloat!
    var calculateButtonWidth:CGFloat!
    var calculateButtonHeight:CGFloat!
    var calculateButtonStartHeight:CGFloat!
    var calculateFontSizeNumber:CGFloat!
    var calculateFontSizeOperator:CGFloat!
    
    //切り替えスイッチ
    var segSwitchWidth:CGFloat!
    var segSwitchHeight:CGFloat!
    var segSwitchFontSize:CGFloat!
    var segSwitchStartPosition:CGFloat!
    var segSwitchMargin:CGFloat!
    
    var displayPanel:UILabel!
    var calculatedPanel:UILabel!
    
    var isFirstDigit = true
    var operand1: Double = 0
    var operation = "="
    
    var displayValue: Double {
        get {
            //notice use of ! twice in below line. If you get that, then you have truely understood optionals :-)
            return NSNumberFormatter().numberFromString(displayPanel.text!)!.doubleValue
        }
        set {
            // Notice how we are using a Property Setter to perform additional tasks while
            //setting value for the property
            displayPanel.text = "\(newValue)"
            isFirstDigit = true
            operation = "="
        }
    }

    func setupScreenItems(){
        
        screenHeight = UIScreen.mainScreen().bounds.height
        screenWidth  = UIScreen.mainScreen().bounds.width
        statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
    
        calculateButtonMargin = 1
        calculateButtonWidth = (screenWidth - calculateButtonMargin * 5)/4
        calculateButtonHeight = calculateButtonWidth * goldenProportion
        calculateButtonStartHeight = screenHeight - calculateButtonHeight * 4 - calculateButtonMargin * 3
        calculateFontSizeNumber = CGFloat(Double(calculateButtonHeight) / 2)
        calculateFontSizeOperator = CGFloat(Double(calculateFontSizeNumber)*1.2)
        
        co2ButtonMargin = calculateButtonMargin
        co2ButtonWidth  = (screenWidth - co2ButtonMargin * 5)/4
        co2ButtonHeight = calculateButtonHeight
        
        segSwitchMargin = 2
        segSwitchWidth  = screenWidth - segSwitchMargin * 2
        segSwitchHeight = calculateButtonHeight * goldenProportion
        segSwitchFontSize = calculateFontSizeNumber
        segSwitchStartPosition = calculateButtonStartHeight - segSwitchMargin - segSwitchHeight
    
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        let size:CGSize  = UIScreen.mainScreen().bounds.size
        print("SCREEN",size)

    }
    
    func buttonCreate(){

        for var h = 0; h < 2; ++h{
            
            for var i = 0; i < 4; ++i{
                
                let button = UIButton()
                button.frame = CGRectMake(co2ButtonMargin + co2ButtonWidth*CGFloat(i) + co2ButtonMargin*CGFloat(i),
                                          co2ButtonMargin + statusBarHeight + co2ButtonHeight*CGFloat(h) + co2ButtonMargin*CGFloat(h),
                                          co2ButtonWidth, co2ButtonHeight)
                button.backgroundColor = UIColor.lightGrayColor()
                button.tag = 100 + i + h*4
                button.setTitle(String(button.tag), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.redColor(), forState:UIControlState.Highlighted)
                button.adjustsImageWhenHighlighted = true
                button.titleLabel?.textColor = UIColor.grayColor()
                button.titleLabel?.adjustsFontSizeToFitWidth = true;
                button.addTarget(self, action: "buttonTouchDown:", forControlEvents:.TouchDown)
                self.view.addSubview(button)
                
            }
        }
        
        let segSwitch = UISegmentedControl()
        segSwitch.frame = CGRectMake(segSwitchMargin, segSwitchStartPosition, segSwitchWidth, segSwitchHeight)
        
        print(segSwitch.frame)
        
        self.view.addSubview(segSwitch)
        
    }
    
    func segSwitchSet(){
    
        // セグメントに設定するボタンを配列で作成
        let array : NSArray = ["1","2","3"]
        let segSwitch: UISegmentedControl = UISegmentedControl(items: array as [AnyObject])
        segSwitch.frame = CGRectMake(segSwitchMargin, segSwitchStartPosition, segSwitchWidth, segSwitchHeight)
        segSwitch.selectedSegmentIndex = 0
        segSwitch.tag = 1000
        segSwitch.momentary = false
        segSwitch.backgroundColor = UIColor.grayColor()
        segSwitch.tintColor = UIColor.whiteColor()
        segSwitch.addTarget(self, action: "segmentChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segSwitch)

    }
    
    func segmentChanged(segcon: UISegmentedControl){
        switch segcon.selectedSegmentIndex {
        case 0:
            print("Tap 0")
        case 1:
            print("Tap 1")
        case 2:
            print("Tap 2")
        default:
            print("Error")
        }
    }
    
    
    func displayPanelCreate(){
        
        let panelMargin:CGFloat  = 10.0
        let displayPanelWidth:CGFloat   = screenWidth - panelMargin * 2.0
        let displayPanelHeight:CGFloat  = calculateFontSizeOperator * 2
        let displayPanelStartPosition:CGFloat = co2ButtonHeight * 2 + co2ButtonMargin * 2 + panelMargin + statusBarHeight
        let displayPanelFrame:CGRect = CGRectMake(panelMargin, displayPanelStartPosition, displayPanelWidth, displayPanelHeight)
        let displayPanelFont = UIFont(name:"HelveticaNeue-Light",size:calculateFontSizeOperator)
        
        let calculatePanelWidth:CGFloat   = screenWidth - panelMargin * 2.0
        let calculatePanelHeight:CGFloat  = segSwitchStartPosition - panelMargin * 2 - (displayPanelStartPosition + displayPanelHeight)
        let calculatePanelStartPosition:CGFloat = statusBarHeight + co2ButtonHeight * 2 + co2ButtonMargin * 2 + panelMargin + displayPanelHeight + panelMargin
        let calculatePanelFrame:CGRect = CGRectMake(panelMargin, calculatePanelStartPosition, calculatePanelWidth, calculatePanelHeight)
        let calculatePanelFont = UIFont(name:"HelveticaNeue-Light",size:calculateFontSizeOperator * 2)

        displayPanel = UILabel(frame:displayPanelFrame)
        displayPanel.backgroundColor = UIColor.darkGrayColor()
        displayPanel.text = ""
        //displayPanel.layer.masksToBounds = true
        //displayPanel.layer.cornerRadius = 10.0
        displayPanel.layer.borderWidth = 1
        displayPanel.layer.borderColor = UIColor.lightGrayColor().CGColor
        displayPanel.font = displayPanelFont
        displayPanel.textColor = UIColor.whiteColor()
        displayPanel.textAlignment = NSTextAlignment.Right
        displayPanel.numberOfLines = 0
        //displayPanel.sizeToFit()
        //displayPanel.layer.shadowOpacity = 0.5
        self.view.addSubview(displayPanel)
    
        calculatedPanel = UILabel(frame:calculatePanelFrame)
        calculatedPanel.backgroundColor = UIColor.blackColor()
        calculatedPanel.text = ""
        //calculatedPanel.layer.masksToBounds = true
        //calculatedPanel.layer.cornerRadius = 10.0
        calculatedPanel.font = calculatePanelFont
        calculatedPanel.layer.borderWidth = 1
        calculatedPanel.layer.borderColor = UIColor.lightGrayColor().CGColor
        calculatedPanel.textColor = UIColor.whiteColor()
        calculatedPanel.textAlignment = NSTextAlignment.Right
        calculatedPanel.numberOfLines = 1
        //calculatedPanel.sizeToFit()
        //calculatedPanel.layer.shadowOpacity = 0.5
        self.view.addSubview(calculatedPanel)

    }
    
    
    func decimalPadCreate(){
    
        let keyArray   = ["7","8","9","÷","4","5","6","×","1","2","3","-",".","0","+","="]
        let colorArray = ["0","0","0","1","0","0","0","1","0","0","0","1","0","0","1","1"]
        
        print("screenHeight", screenHeight)
        print("screenWidth",screenWidth)
        print("buttonWidth",calculateButtonWidth)
        print("buttonHeight",calculateButtonHeight)
        print("fontSizeNumber",calculateFontSizeNumber)
        print("fontSizeOperator",calculateFontSizeOperator)
        
        for var h = 0; h < 4; ++h{
            
            for var i = 0; i < 4; ++i{
                
                let button = UIButton()
                button.frame = CGRectMake(calculateButtonMargin + calculateButtonWidth*CGFloat(i) + calculateButtonMargin*CGFloat(i),
                    calculateButtonStartHeight + calculateButtonHeight*CGFloat(h) + calculateButtonMargin*CGFloat(h) + calculateButtonHeight * 4,
                    calculateButtonWidth, calculateButtonHeight)
                button.tag = i + h*4
            
                button.setTitle(String(keyArray[button.tag]), forState: UIControlState.Normal)
                button.titleLabel?.textColor = UIColor.grayColor()
                //button.adjustsImageWhenHighlighted = true
                
                if colorArray[button.tag]=="0"{
                    
                    let numberFont = UIFont(name:"HelveticaNeue-Light",size:calculateFontSizeNumber)
                    let numberFontSize = button.titleLabel?.text!.sizeWithAttributes([NSFontAttributeName : numberFont!])
                    let numberFontHeightMargin:CGFloat = (calculateButtonHeight - (numberFontSize?.height)!)/2
                    let numberFontWithMargin:CGFloat   = (calculateButtonWidth - (numberFontSize?.width)!)/2
                    button.backgroundColor = UIColor.lightGrayColor()
                    button.titleLabel?.font = numberFont
                    print(numberFontSize)
                    button.titleEdgeInsets = UIEdgeInsetsMake(numberFontHeightMargin, numberFontWithMargin, numberFontHeightMargin, numberFontWithMargin)
                    
                }else{
                
                    let operatorFont = UIFont(name:"HelveticaNeue-Light",size:calculateFontSizeOperator)
                    let operatorFontSize = button.titleLabel?.text!.sizeWithAttributes([NSFontAttributeName : operatorFont!])
                    let operatorFontHeightMargin:CGFloat = (calculateButtonHeight - (operatorFontSize?.height)!)/2
                    let operatorFontWithMargin:CGFloat   = (calculateButtonWidth - (operatorFontSize?.width)!)/2
                    let margin:CGFloat = calculateButtonHeight / 24
                    button.backgroundColor = UIColor.orangeColor()
                    button.titleLabel?.font = UIFont(name:"HelveticaNeue-Light",size:calculateFontSizeOperator)
                    button.titleEdgeInsets = UIEdgeInsetsMake(operatorFontHeightMargin - margin, operatorFontWithMargin, operatorFontHeightMargin + margin, operatorFontWithMargin)
                }
                
                button.addTarget(self, action: "buttonTouchDown:", forControlEvents:.TouchDown)
                button.addTarget(self, action: "appendDigit:", forControlEvents:.TouchDown)
                self.view.addSubview(button)
                
                UIView.animateWithDuration(0.1 * Double(i+h*4), animations: { () -> Void in
                    button.frame = CGRectMake(self.calculateButtonMargin + self.calculateButtonWidth*CGFloat(i) + self.calculateButtonMargin*CGFloat(i),
                        self.calculateButtonStartHeight + self.calculateButtonHeight*CGFloat(h) + self.calculateButtonMargin*CGFloat(h),
                        self.calculateButtonWidth, self.calculateButtonHeight)
                    
                })
            }
        }
    }
    
    func appendDigit(sender: UIButton) {
        
        print("onClickMyButton:")
        print("sender.currentTitile: \(sender.currentTitle)")
        print("sender.tag:\(sender.tag)")
        
        let digit = sender.currentTitle!
        //Notice use of ternery operator in below line which results in a single line code
        //instead of usual if-else multiple lines
        displayPanel.text = isFirstDigit ? digit : displayPanel.text! + digit
        isFirstDigit = false
    }
    
    func clearDisplay(sender: AnyObject) {
     
        displayValue = 0
    
    }
    
    func saveOperand(sender: UIButton) {
        
        operation = sender.currentTitle!
        operand1 = displayValue
        isFirstDigit = true
    
    }
    
    func calculate(sender: AnyObject) {
        
        switch operation {
            case "÷":displayValue = operand1 / displayValue
            case "×":displayValue *= operand1
            case "+":displayValue += operand1
            case "−":displayValue = operand1 - displayValue
            default:break
        }
    }
    
    func buttonTouchDown(sender:UIButton){

        let backColor:UIColor = sender.backgroundColor!
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            sender.backgroundColor = UIColor().colorWithAlphaComponent(0.5)
            
            }, completion: {
                (value: Bool) in
                sender.backgroundColor = backColor
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.darkGrayColor()

        self.setupScreenItems()
        self.buttonCreate()
        self.decimalPadCreate()
        self.segSwitchSet()
        self.displayPanelCreate()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

