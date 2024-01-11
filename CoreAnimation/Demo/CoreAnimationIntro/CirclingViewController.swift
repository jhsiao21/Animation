//
//  CirclingViewController.swift
//  CoreAnimationIntro
//
//  Created by LoganMacMini on 2023-12-28.
//

import UIKit

class CirclingViewController: UIViewController {

    let redView = UIView()
    let _width: CGFloat = 40
    let _height: CGFloat = 40
    
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300
        
    let button = makeButton(withText: "Animate")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
//        redCircle.backgroundColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(redView)
        view.addSubview(redCircle)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // draw box
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)

        // draw circle
        redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                               y: view.bounds.midY - _diameter/2,
                               width: _diameter, height: _diameter)

        //使用指定的大小創建渲染器
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))

        //使用繪圖動作創建圖像
        let img = renderer.image { ctx in
            
            // 在渲染器內繪製圖像
            let rectangle = CGRect(x: 0,
                                   y: 0,
                                   width: _diameter,
                                   height: _diameter)

            //設定描邊顏色
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            // 設定填充顏色
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            // 設定描邊寬度
            ctx.cgContext.setLineWidth(1)
            //使用 addEllipse 在指定的矩形內添加一個橢圓(只有添加)
            ctx.cgContext.addEllipse(in: rectangle)
            //使用 drawPath(using:) 方法繪製橢圓，同時使用 .fillStroke 來實現描邊和填充。
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        redCircle.image = img
    }
    
    func animate() {
        //定義動畫範圍
        let boundingRect = CGRect(x: -_diameter/2,
                                  y: -_diameter/2,
                                  width: _diameter,
                                  height: _diameter)
        
        let orbit = CAKeyframeAnimation()
        //設定動畫的屬性，position，表示位置
        orbit.keyPath = "position"
        
        //設定了動畫的路徑，使用 CGPath 創建了一個橢圓形的路徑
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        
        
        orbit.duration = 2
        //設定為 true 以便在動畫期間將結果添加到屬性的當前值
        orbit.isAdditive = true
        //重複次數
        orbit.repeatCount = HUGE
        //.paced: 設定了計算模式，這裡是 .paced，表示動畫將以相同的速度進行
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        redView.layer.add(orbit, forKey: "redbox")
    }

    @objc func buttonTapped(_ sender: UIButton) {
        animate()
    }
}

