//
//  OnboardingViewController.swift
//  Linker
//
//  Created by Luke Cheskin on 09/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var ViewControllerArray: [UIViewController] = {
        return [self.ViewControllerInstance(name: "Onboarding1"),
                self.ViewControllerInstance(name: "Onboarding2"),
                self.ViewControllerInstance(name: "Onboarding3")]
    }()
    
    private func ViewControllerInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = ViewControllerArray.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = ViewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return ViewControllerArray.last
        }
        
        guard ViewControllerArray.count > previousIndex else {
            return nil
        }
        
        return ViewControllerArray[previousIndex]
        
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = ViewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < ViewControllerArray.count else {
            return ViewControllerArray.first
        }
        
        guard ViewControllerArray.count > nextIndex else {
            return nil
        }
        
        return ViewControllerArray[nextIndex]
        
    }
    
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewControllerArray.count
    }
    
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = ViewControllerArray.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
        
    }
}
