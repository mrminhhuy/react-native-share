#import "ShareImages.h"
#import <React/RCTLog.h>
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import <React/RCTImageLoader.h>

@implementation ShareImages

@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

- (NSArray*)excludedActivitiesForKeys:(NSArray*)passedKeys {
    NSDictionary *activities = @{
       @"postToFacebook": UIActivityTypePostToFacebook,
       @"postToTwitter": UIActivityTypePostToTwitter,
       @"message": UIActivityTypeMessage,
       @"mail": UIActivityTypeMail,
       @"print": UIActivityTypePrint,
       @"copyToPasteboard": UIActivityTypeCopyToPasteboard,
       @"assignToContact": UIActivityTypeAssignToContact,
       @"saveToCameraRoll": UIActivityTypeSaveToCameraRoll,
       @"addToReadingList": UIActivityTypeAddToReadingList,
       @"postToFlickr": UIActivityTypePostToFlickr,
       @"postToVimeo": UIActivityTypePostToVimeo,
       @"postToTencentWeibo": UIActivityTypePostToTencentWeibo,
       @"airDrop": UIActivityTypeAirDrop
    };

    NSMutableArray *excludedActivities = [NSMutableArray new];

    [passedKeys enumerateObjectsUsingBlock:^(NSString *activityName, NSUInteger idx, BOOL *stop) {
        NSString *activity = [activities objectForKey:activityName];
        if (!activity) {
            RCTLogWarn(@"[ShareImages] Unknown activity to exclude: %@. Expected one of: %@", activityName, [activities allKeys]);
            return;
        }
        [excludedActivities addObject:activity];
    }];

    return excludedActivities;
}

RCT_EXPORT_METHOD(show:(NSDictionary *)args)
{
    NSArray *imageBase64 = args[@"images"];
    NSMutableArray *images = [NSMutableArray array];
    __block UIImage *shareImage;
    if (imageBase64) {
        for(int i = 0; i < [imageBase64 count]; i++){
            @try {
                NSData *decodedImage = [[NSData alloc] initWithBase64EncodedString:[imageBase64 objectAtIndex:i]
                                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
                shareImage = [UIImage imageWithData:decodedImage];
                [images addObject:shareImage];
            } @catch (NSException *exception) {
                RCTLogWarn(@"[ShareImages] ERROR");
            }
        }
    }
    return [self showWithOptions:args image:shareImage images: images];
}

- (void) showWithOptions:(NSDictionary *)args image:(UIImage *)image images:(NSMutableArray *) images
{
    NSMutableArray *shareObject = [NSMutableArray array];
    NSArray *activitiesToExclude = args[@"exclude"];
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:images applicationActivities:nil];
    activityView.excludedActivityTypes = activitiesToExclude
        ? [self excludedActivitiesForKeys:activitiesToExclude]
        : nil;
    UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([activityView respondsToSelector:@selector(popoverPresentationController)]) {
        activityView.popoverPresentationController.sourceView = ctrl.view;
        CGRect sourceRect = CGRectMake(ctrl.view.center.x, ctrl.view.center.y, 1, 1);
        activityView.popoverPresentationController.sourceRect = sourceRect;
        activityView.popoverPresentationController.permittedArrowDirections = 0;
    }
    [ctrl presentViewController:activityView animated:YES completion:nil];
}

@end
