//
//  UIView+Ext.swift
//  Sentient Me
//
//  Created by Prince Saini on 14/06/23.
//

import UIKit

extension UIView{
   func addBorder(){
       self.layer.cornerRadius = 5
       self.layer.borderColor = UIColor.black.cgColor
       self.layer.borderWidth = 1
    }
    
    class ClickListener: UITapGestureRecognizer {
        var onClick : (() -> Void)? = nil
    }
    
    func setOnClickListener(action :@escaping () -> Void){
          let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
          tapRecogniser.onClick = action
          self.addGestureRecognizer(tapRecogniser)
      }
      
      @objc func onViewClicked(sender: ClickListener) {
          if let onClick = sender.onClick {
              onClick()
          }
      }
}

