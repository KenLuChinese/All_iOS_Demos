

#import "UIScrollView+__Category.h"

@implementation UIScrollView (__Category)

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}

- (void)setContentOffsetX:(CGFloat)x animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(x, self.contentOffset.y) animated:animated];
}

- (void)setContentOffsetY:(CGFloat)y animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.contentOffset.x, y) animated:animated];
}

- (CGPoint)topContentOffset {
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)bottomContentOffset {
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)leftContentOffset {
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)rightContentOffset {
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}

- (ScrollDirection)ScrollDirection {
    ScrollDirection direction;
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f) {
        direction = ScrollDirectionUp;
    } else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f) {
        direction = ScrollDirectionDown;
    } else if ([self.panGestureRecognizer translationInView:self].x < 0.0f) {
        direction = ScrollDirectionLeft;
    } else if ([self.panGestureRecognizer translationInView:self].x > 0.0f) {
        direction = ScrollDirectionRight;
    } else {
        direction = ScrollDirectionNone;
    }
    return direction;
}

- (BOOL)isScrolledToTop {
    return self.contentOffset.y <= [self topContentOffset].y;
}

- (BOOL)isScrolledToBottom {
    return self.contentOffset.y >= [self bottomContentOffset].y;
}

- (BOOL)isScrolledToLeft {
    return self.contentOffset.x <= [self leftContentOffset].x;
}

- (BOOL)isScrolledToRight {
    return self.contentOffset.x >= [self rightContentOffset].x;
}

- (void)scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:[self topContentOffset] animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    [self setContentOffset:[self bottomContentOffset] animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    [self setContentOffset:[self leftContentOffset] animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated {
    [self setContentOffset:[self rightContentOffset] animated:animated];
}

- (void)stopScrolling {
    [self setContentOffset:CGPointMake(0, MIN(self.contentSize.height - CGRectGetHeight(self.frame), self.contentOffset.y)) animated:NO];
}

- (NSUInteger)verticalPageIndex {
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)horizontalPageIndex {
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

- (void)scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

@end
