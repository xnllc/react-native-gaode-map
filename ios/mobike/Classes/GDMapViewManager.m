//
//  GDMapViewManager.m
//  mobike
//
//  Created by Uncle Charlie on 25/2/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "GDMapViewManager.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <React/RCTConvert+CoreLocation.h>
#import "GDPointAnnotation.h"

@interface GDMapViewManager()<MAMapViewDelegate>

@end

@implementation GDMapViewManager

RCT_EXPORT_MODULE(GDMapView)

RCT_EXPORT_VIEW_PROPERTY(mapType, int)
RCT_EXPORT_VIEW_PROPERTY(zoom, float)
RCT_EXPORT_VIEW_PROPERTY(marker, NSDictionary*)
RCT_EXPORT_VIEW_PROPERTY(markers, NSArray*)
RCT_EXPORT_VIEW_PROPERTY(zoomEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showsCompass, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
//RCT_CUSTOM_VIEW_PROPERTY(center, CLLocationCoordinate2D, GDMapView) {
//  [view setCenterCoordinate:json ? [RCTConvert CLLocationCoordinate2D:json] : defaultView.centerCoordinate];
//}

- (UIView *)view {
  GDMapView *mapView = [GDMapView new];
  mapView.delegate = self;
  // MAMapView *mapView = [[MAMapView alloc] init];
  mapView.showsUserLocation = YES;
  mapView.userTrackingMode = MAUserTrackingModeFollow;
  
  return mapView;
}

- (void)setUp {
  
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
  if(![annotation isKindOfClass: MAPointAnnotation.class]) {
    return nil;
  }
  
  static NSString *annotationReuseID = @"GDAnnotationID";
  GDPointAnnotation *gdAnnotation = (GDPointAnnotation *)annotation;
  MAPinAnnotationView *annotationView
    = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationReuseID];
  if(!annotationView) {
    annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationReuseID];
  }
  
  annotationView.canShowCallout               = YES;
  annotationView.animatesDrop                 = YES;
  annotationView.draggable                    = YES;
  annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  annotationView.pinColor                     = (int)gdAnnotation.category;
  
  return annotationView;
}

- (void)sendEvent:(GDMapView *)mapView params:(NSDictionary *)params {
    if(!mapView.onChange) {
      return;
    }
  
  //  NSInteger c = mapView.count;
  
    mapView.onChange(@{});
}

@end
