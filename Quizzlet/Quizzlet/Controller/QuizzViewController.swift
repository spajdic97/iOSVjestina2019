//
//  QuizzViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 06/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class QuizzViewController: UIViewController, UIScrollViewDelegate {
    
    var quizz: Quizz?
    var text: String?
    
    var label = UILabel.newAutoLayout()
    var image = UIImageView.newAutoLayout()
    var button = UIButton.newAutoLayout()
    
    var container = UIView.newAutoLayout()
    var scrollView = UIScrollView.newAutoLayout()
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.delegate = self
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = quizz?.questions.count ?? 1
        
        setUI()

        print(quizz?.questions ?? 1)
    }
    
    
    func setUI() {
        
        // Question title label
        
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = quizz?.title
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: (navigationController?.navigationBar.frame.height)! + 25.0)
        label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        label.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
        // Question picture
        
        image.autoSetDimension(.height, toSize: 120)
        image.image = quizz?.image
        image.clipsToBounds = true
        image.backgroundColor = .red
        view.addSubview(image)
        
        image.autoPinEdge(.top, to: .bottom, of: label, withOffset: 20)
        image.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        image.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        
        // Start quizz button
        
        button.autoSetDimension(.height, toSize: 50)
        view.addSubview(button)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.setTitle("Start quizz", for: .normal)
        
        button.autoPinEdge(.top, to: .bottom, of: image, withOffset: 30)
        button.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        button.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
        button.addTarget(self, action: #selector(btnStartQuizzTapped), for: .touchUpInside)
        
        // Container for scroll view
        
        container.autoSetDimension(.height, toSize: 270)
        view.addSubview(container)
        container.backgroundColor = .red
        
        container.autoPinEdge(.top, to: .bottom, of: button, withOffset: 20)
        container.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        container.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        container.isHidden = true
        
        // Scroll View
        
        scrollView.frame = CGRect(x: container.frame.minX, y: container.frame.minY, width: UIScreen.main.bounds.width - 40, height: 270)
        container.addSubview(scrollView)
        scrollView.backgroundColor = .purple
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(quizz?.questions.count ?? 1), height: 270)
        
        
        if let quizz = self.quizz {

            for index in 0..<quizz.questions.count {

                let questionView = QuestionView()


                questionView.frame.origin.x = scrollView.frame.size.width * CGFloat(index)

                questionView.questionText.text = quizz.questions[index].question
                questionView.btnA.setTitle(quizz.questions[index].answers[0], for: .normal)
                questionView.btnB.setTitle(quizz.questions[index].answers[1], for: .normal)
                questionView.btnC.setTitle(quizz.questions[index].answers[2], for: .normal)
                questionView.btnD.setTitle(quizz.questions[index].answers[3], for: .normal)

                questionView.btnA.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                questionView.btnB.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                questionView.btnC.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                questionView.btnD.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                print("postavljam selectore")

                scrollView.addSubview(questionView)
            }

        }
        
    }
    
    
    @objc func btnStartQuizzTapped(sender: UIButton) {
        container.isHidden = false
        sender.isEnabled = false
    }
    
    
    @objc func buttonClicked(sender: UIButton)
    {
        checkCorrectness(sender: sender)
        print("clicked")
    }

    func checkCorrectness(sender: UIButton) {
        if sender.titleLabel?.text == "yes" {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
    
    

}