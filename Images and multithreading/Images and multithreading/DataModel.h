//
//  DataModel.h
//  Images and multithreading
//
//  Created by Alesia Adereyko on 17/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum statuses {
    notLoaded,
    loading,
    loaded,
    error
};

@interface DataModel : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *urlString;
@property (assign, nonatomic) enum statuses status;

@end
