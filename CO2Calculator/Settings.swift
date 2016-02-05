//
//  Settings.swift
//  CO2Calculator
//
//  Created by LEE  SEIKAI on 2016/01/23.
//  Copyright © 2016年 SHL Consulting. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(r r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    class func GreenColor() -> UIColor {
        return UIColor.rgb(r: 82, g: 204, b: 134, alpha: 1.0)
    }
    class func MazentaColor() -> UIColor {
        return UIColor.rgb(r: 243, g: 173, b: 30, alpha: 1.0)
    }
}

/*
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define GREEN_COLOR [UIColor colorWithRed:82.0/255.0 green:204.0/255.0 blue:134.0/255.0 alpha:1]
#define GREEN_BACK_COLOR [UIColor colorWithRed:82.0/255.0 green:204.0/255.0 blue:134.0/255.0 alpha:0.5]
#define GRASS_COLOR [UIColor colorWithRed:157.0/255.0 green:169.0/255.0 blue:57.0/255.0 alpha:1]
#define RED_COLOR [UIColor colorWithRed:236.0/255.0 green:106.0/255.0 blue:70.0/255.0 alpha:1]
#define RED_BACK_COLOR [UIColor colorWithRed:236.0/255.0 green:106.0/255.0 blue:70.0/255.0 alpha:0.5]
#define CYAN_COLOR [UIColor colorWithRed:123.0/255.0 green:193.0/255.0 blue:191.0/255.0 alpha:1]
#define MAZENTA_COLOR [UIColor colorWithRed:243.0/255.0 green:173.0/255.0 blue:30.0/255.0 alpha:1]
#define BLUE_COLOR [UIColor colorWithRed:120.0/255.0 green:148.0/255.0 blue:193.0/255.0 alpha:1]
#define DARKBLUE_COLOR [UIColor colorWithRed:65.0/255.0 green:114.0/255.0 blue:196.0/255.0 alpha:1]
#define WHITE_COLOR [UIColor colorWithRed:240.0/255.0 green:235.0/255.0 blue:230.0/255.0 alpha:1]
#define WHITE_COLOR1 [UIColor colorWithRed:235.0/255.0 green:230.0/255.0 blue:225.0/255.0 alpha:1]
#define WHITE_COLOR2 [UIColor colorWithRed:230.0/255.0 green:225.0/255.0 blue:220.0/255.0 alpha:1]
#define WHITE_COLOR3 [UIColor colorWithRed:225.0/255.0 green:220.0/255.0 blue:210.0/255.0 alpha:1]
#define LIGHTGRAY_COLOR [UIColor colorWithRed:210.0/255.0 green:205.0/255.0 blue:200.0/255.0 alpha:1]
#define GRAY_COLOR [UIColor colorWithRed:153.0/255.0 green:147.0/255.0 blue:139.0/255.0 alpha:1]
#define DARKGRAY_COLOR [UIColor colorWithRed:110.0/255.0 green:105.0/255.0 blue:100.0/255.0 alpha:1]
#define BLACK_COLOR [UIColor colorWithRed:50.0/255.0 green:45.0/255.0 blue:40.0/255.0 alpha:1]
#define CLEAR_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.0]
*/
