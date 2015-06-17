
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

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        
        [_containerView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:_containerView];
        
        _loadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingActivityIndicator.color = [UIColor blackColor];
        [_loadingActivityIndicator setCenter:_containerView.center];
        
        [_containerView addSubview:_loadingActivityIndicator];
        _fixedHeight = CGRectGetHeight(frame);
        
        [self changeStateOfControl:MNMBottomPullToRefreshViewStateIdle offset:CGFLOAT_MAX];
    }
    return self;
}

/*
 * Changes the state of the control depending on state_ value
 */
- (void)changeStateOfControl:(MNMBottomPullToRefreshViewState)state offset:(CGFloat)offset
{
    self.state = state;
    
    CGFloat height = self.fixedHeight;
    
    switch (self.state) {
        
        case MNMBottomPullToRefreshViewStateIdle: {
            
            [self.loadingActivityIndicator stopAnimating];
            break;
            
        } case MNMBottomPullToRefreshViewStatePull: {
            
            [self.loadingActivityIndicator startAnimating];
            break;
            
        } case MNMBottomPullToRefreshViewStateRelease: {
            
            height = self.fixedHeight + fabs(offset);
            break;
            
        } case MNMBottomPullToRefreshViewStateLoading: {

            height = self.fixedHeight + fabs(offset);
            break;
            
        } default:
            break;
    }
    
//    CGRect frame = self.frame;
//    frame.size.height = height;
//    [self setFrame:frame];
//    [self setNeedsLayout];
}

#pragma mark -
#pragma mark Properties

/*
 * Returns state of activity indicator
 */
- (BOOL)isLoading {
    
    return [self.loadingActivityIndicator isAnimating];
}

@end
