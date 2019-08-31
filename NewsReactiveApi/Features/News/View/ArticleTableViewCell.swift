//
//  ArticleTableViewCell.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/29/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
 
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
  }
  
  public func setup(article: ArticleViewModel){
    titleLabel.text = article.article.title
    descriptionLabel.text = article.article.description ?? "Not avialablable"
    dateLabel.text = article.article.publishedAt?.dateFormat() ?? "No especified"
  }
}
