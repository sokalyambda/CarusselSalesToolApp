/*
 * Copyright (c) 2012 Mario Negro Martín
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */

#import "MNMBottomPullToRefreshView.h"

@interface MNMBottomPullToRefreshView()

/*
 * View that contains all controls
 */
@property (nonatomic, readwrite, strong) UIView *containerView;

/*
 * Activiry indicator to show while loading
 */
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *loadingActivityIndicator;

/*
 * Current state of the control
 */
@property (nonatomic, readwrite, assign) MNMBottomPullToRefreshViewState state;

@end

@implementation MNMBottomPullToRefreshView

#pragma mark -
#pragma mark Initialization

/*
 * Initializes and returns a newly allocated view object with the specified frame rectangle.
 *
 * @param aRect: The frame rectangle for the view, measured in points.
 * @return An initialized view object or nil if the object couldn't be created.
 */
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        
        [_containerView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:_containerView];
        
        _loadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingActivityIndicator.color = [UIColor blackColor];
        [_loadingActivityIndicator setCenter:self.containerView.center];
        [_loadingActivityIndicator setHidesWhenStopped:YES];
        
        [_containerView addSubview:self.loadingActivityIndicator];
        _fixedHeight = CGRectGetHeight(frame);
        
        [self changeStateOfControl:MNMBottomPullToRefreshViewStateIdle offset:CGFLOAT_MAX];
    }
    
    return self;
}

/*
 * Changes the state of the control depending on state_ value
 */
- (void)changeStateOfControl:(MNMBottomPullToRefreshViewState)state offset:(CGFloat)offset {
    
    _state = state;
    
    CGFloat height = _fixedHeight;
    
    switch (_state) {
        
        case MNMBottomPullToRefreshViewStateIdle: {
            
            [_loadingActivityIndicator stopAnimating];
            break;
            
        } case MNMBottomPullToRefreshViewStatePull: {
            
            [_loadingActivityIndicator startAnimating];
            break;
            
        } case MNMBottomPullToRefreshViewStateRelease: {
            
            height = _fixedHeight + fabs(offset);
            break;
            
        } case MNMBottomPullToRefreshViewStateLoading: {

            height = _fixedHeight + fabs(offset);
            break;
            
        } default:
            break;
    }
    
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:frame];
    
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark Properties

/*
 * Returns state of activity indicator
 */
- (BOOL)isLoading {
    
    return [_loadingActivityIndicator isAnimating];
}

@end
