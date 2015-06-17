
#import "MNMBottomPullToRefreshManager.h"
#import "MNMBottomPullToRefreshView.h"

static CGFloat const kAnimationDuration = 0.4f;

@interface MNMBottomPullToRefreshManager()

/*
 * Pull-to-refresh view
 */
@property (nonatomic, readwrite, strong) MNMBottomPullToRefreshView *pullToRefreshView;

/*
 * Table view which p-t-r view will be added
 */
@property (nonatomic, readwrite, weak) UITableView *table;

/*
 * Client object that observes changes
 */
@property (nonatomic, readwrite, weak) id<MNMBottomPullToRefreshManagerClient> client;

/*
 * Returns the correct offset to apply to the pull-to-refresh view, depending on contentSize
 *
 * @return The offset
 * @private
 */
- (CGFloat)tableScrollOffset;

@end

@implementation MNMBottomPullToRefreshManager

#pragma mark -
#pragma mark Accessors

- (BOOL)isLoading
{
    _isLoading = self.pullToRefreshView.isLoading;
    return _isLoading;
}

#pragma mark -
#pragma mark Instance initialization

/*
 * Initializes the manager object with the information to link view and table
 */
- (id)initWithPullToRefreshViewHeight:(CGFloat)height tableView:(UITableView *)table withClient:(id<MNMBottomPullToRefreshManagerClient>)client
{
    if (self = [super init]) {
        _client = client;
        _table = table;
        _pullToRefreshView = [[MNMBottomPullToRefreshView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_table.frame), height)];
    }
    
    return self;
}

#pragma mark -
#pragma mark Visuals

/*
 * Returns the correct offset to apply to the pull-to-refresh view, depending on contentSize
 */
- (CGFloat)tableScrollOffset
{
    CGFloat offset = 0.0f;
    
    if (self.table.contentSize.height < CGRectGetHeight(self.table.frame)) {
        offset = -self.table.contentOffset.y;
    } else {
        offset = (self.table.contentSize.height - self.table.contentOffset.y) - CGRectGetHeight(self.table.frame);
    }
    
    return offset;
}

/*
 * Relocate pull-to-refresh view
 */
- (void)relocatePullToRefreshView
{
    CGFloat yOrigin = 0.0f;
    
    if (self.table.contentSize.height >= CGRectGetHeight(self.table.frame)) {
        yOrigin = self.table.contentSize.height;
    } else {
        yOrigin = CGRectGetHeight(self.table.frame);
    }
    
    CGRect frame = self.pullToRefreshView.frame;
    frame.origin.y = yOrigin;
    [self.pullToRefreshView setFrame:frame];
    
    [self.table addSubview:self.pullToRefreshView];
}

/*
 * Sets the pull-to-refresh view visible or not. Visible by default
 */
- (void)setPullToRefreshViewVisible:(BOOL)visible
{
    [self.pullToRefreshView setHidden:!visible];
}

#pragma mark -
#pragma mark Table view scroll management

/*
 * Checks state of control depending on tableView scroll offset
 */
- (void)tableViewScrolled
{
    if (!self.pullToRefreshView.isHidden && !self.pullToRefreshView.isLoading) {
        
        CGFloat offset = self.tableScrollOffset;

        if (offset >= 0.0f) {
            [self.pullToRefreshView changeStateOfControl:MNMBottomPullToRefreshViewStateIdle offset:offset];
        } else if (offset <= 0.0f && offset >= -self.pullToRefreshView.fixedHeight) {
            [self.pullToRefreshView changeStateOfControl:MNMBottomPullToRefreshViewStatePull offset:offset];
        } else {
            [self.pullToRefreshView changeStateOfControl:MNMBottomPullToRefreshViewStateRelease offset:offset];
        }
    }
}

/*
 * Checks releasing of the tableView
 */
- (void)tableViewReleased
{
    if (!self.pullToRefreshView.isHidden) {
        
        CGFloat offset = self.tableScrollOffset;
        CGFloat height = -self.pullToRefreshView.fixedHeight;
        
        if (offset <= 0.0f && offset < height) {
            
            [self.client bottomPullToRefreshTriggered:self];
            
            [self.pullToRefreshView changeStateOfControl:MNMBottomPullToRefreshViewStateLoading offset:offset];
            
            [UIView animateWithDuration:kAnimationDuration animations:^{
                
                if (self.table.contentSize.height >= CGRectGetHeight(self.table.frame)) {
                
                    [self.table setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, -height, 0.0f)];
                    
                } else {
                    
                    [self.table setContentInset:UIEdgeInsetsMake(height, 0.0f, 0.0f, 0.0f)];
                }
            }];
        }
    }
}

/*
 * The reload of the table is completed
 */
- (void)tableViewReloadFinished
{
    [self.table setContentInset:UIEdgeInsetsZero];

    [self relocatePullToRefreshView];
    
    [self.pullToRefreshView changeStateOfControl:MNMBottomPullToRefreshViewStateIdle offset:CGFLOAT_MAX];
}

@end