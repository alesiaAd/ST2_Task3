//
//  DataModel.h
//  Images and multithreading
//
//  Created by Alesia Adereyko on 17/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoadingProgressStatus) {
    LoadingProgressStatusNotLoaded,
    LoadingProgressStatusLoading,
    LoadingProgressStatusLoaded,
    LoadingProgressStatusError
};

@interface DataModel : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *urlString;
@property (assign, nonatomic) LoadingProgressStatus status;

@end
