//
//  RestaurantTableViewCell.m
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "RestaurantTableViewCell.h"

@interface RestaurantTableViewCell()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *isFavoriteButton;

@end

@implementation RestaurantTableViewCell

@synthesize name=_name, price=_price, category=_category, isFavorite=_isFavorite;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.backgroundColor = [UIColor clearColor];
        
        //
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.text = _name;
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView addSubview:self.nameLabel];
        
        //
        self.categoryLabel = [[UILabel alloc] init];
        self.categoryLabel.backgroundColor = [UIColor clearColor];
        self.categoryLabel.text = _category;
        self.categoryLabel.textColor = [UIColor grayColor];
        self.categoryLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.categoryLabel];
        
        //
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.textColor = [UIColor lightGrayColor];
        self.priceLabel.numberOfLines = 2;
        self.priceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.priceLabel];
        
        self.isFavoriteButton = [[UIButton alloc] init];
        [self.isFavoriteButton addTarget:self action:@selector(favoriteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.isFavoriteButton setImage:[UIImage imageNamed:@"star_gray.png"] forState:UIControlStateNormal];
        [self.isFavoriteButton setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.isFavoriteButton];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    CGFloat cellWidth = contentRect.size.width;
    
    self.nameLabel.frame = CGRectMake(60, 5, cellWidth/2-30, 20);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    //
    self.categoryLabel.frame = CGRectMake(cellWidth/2+10, 5, cellWidth/2-30, 20);
    self.categoryLabel.font = [UIFont systemFontOfSize:12];
    
    //
    self.priceLabel.frame = CGRectMake(60,
                                         25,
                                         cellWidth-50-30,
                                         30);
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    
    self.isFavoriteButton.frame =CGRectMake(12.5,
                                            20,
                                            17.5,
                                            17.5);
    
}

- (void)favoriteButtonClicked {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickFavoriteOnCellAtIndex:)]) {
        [self.delegate didClickFavoriteOnCellAtIndex:_cellIndex];
    }
}

- (void)setName:(NSString *)name {
    _name=name;
    self.nameLabel.text = _name;
}

- (void)setCategory:(NSString *)category {
    _category=category;
    if(_category.length==0) {
        self.categoryLabel.text = @"無分類";
    } else {
        self.categoryLabel.text=_category;
    }
}

- (void)setPrice:(NSNumber *)price {
    _price=price;
    self.priceLabel.text=[NSString stringWithFormat:@"價格約：%@",_price];
}

- (void)setIsFavorite:(BOOL)isFavorite {
    _isFavorite=isFavorite;
    if(isFavorite) {
        [self.isFavoriteButton setImage:[UIImage imageNamed:@"star_yellow.png"] forState:UIControlStateNormal];
    } else {
        [self.isFavoriteButton setImage:[UIImage imageNamed:@"star_gray.png"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
