//
//  DetailViewController.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet weak var itemWebView: UIWebView!
	
	
	var detailItem: RSSItem? {
		didSet {
			self.configureView()
		}
	}
	
	func configureView() {
		
		if let item: RSSItem = self.detailItem, let webView = self.itemWebView, let path = Bundle.main.path(forResource: "template", ofType: "html") {
			let templateURL = URL(fileURLWithPath: path)
			if var template = try? String(contentsOf: templateURL, encoding: .utf8)
			{
				if let title = item.title
				{
					template = template.replacingOccurrences(of: "###TITLE###", with: title, options: .caseInsensitive, range: nil)
				}
				
				if let content = item.content
				{
					template = template.replacingOccurrences(of: "###CONTENT###", with: content, options: .caseInsensitive, range: nil)
				}
				else if let description = item.itemDescription
				{
					template = template.replacingOccurrences(of: "###CONTENT###", with: description, options: .caseInsensitive, range: nil)
				}
				
				if let date = item.pubDate
				{
					let formatter = DateFormatter()
					formatter.dateFormat = "MMM dd, yyyy"
					
					template = template.replacingOccurrences(of: "###DATE###", with: formatter.string(from: date), options: .caseInsensitive, range: nil)
				}
				
				webView.loadHTMLString(template, baseURL: nil)
			}
			
		}
//		else
//		{
//			if let content = item.content
//			{
//				webView.loadHTMLString(content, baseURL: nil)
//			}
//			else if let description = item.itemDescription
//			{
//				webView.loadHTMLString(description, baseURL: nil)
//			}
//		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureView()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

