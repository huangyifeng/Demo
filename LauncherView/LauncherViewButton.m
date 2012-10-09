//
//  LauncherViewButton.m
//  Gemini
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "LauncherViewButton.h"
#import "NSSafelyRelease.h"
#import "UIColor+GeminiColors.h"
#import "UIImage+RetinaDisplay.h"
#import "GeminiDefines.h"

@interface LauncherViewButton ()

@property(nonatomic, retain) UIButton   *_bodyButton;
@property(nonatomic, retain) UIButton   *_deleteButton;
@property(nonatomic, retain) UILabel    *_nameLabel; 
@property(nonatomic, retain) HomeBadgeView  *_badge;

@property(nonatomic, retain)UILongPressGestureRecognizer    *longPressGes;

- (void)initViewComponent;
- (void)initGestureRecoginzer;
- (void)addDeleteButton;
- (void)removeDeleteButton;
- (void)setEditingMode:(BOOL)editing;
- (void)setDraggingMode:(BOOL)dragging;
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress;
//- (void)handlePanGesture:(UIPanGestureRecognizer *)pan;
- (void)tapDeleteButton;

@end

@implementation LauncherViewButton

@synthesize _bodyButton     = _bodyButton;
@synthesize _deleteButton   = _deleteButton;
@synthesize _nameLabel      = _nameLabel;
@synthesize _badge          = _badge;
@synthesize padding         = _padding;
@synthesize longPressGes    = _longPressGes;
//@synthesize panGes          = _panGes;

@synthesize canDelete       = _canDelete;
@synthesize delegate        = _delegate;

- (void)dealloc
{
    RELEASE_SAFELY(_bodyButton);
    RELEASE_SAFELY(_deleteButton);
    RELEASE_SAFELY(_nameLabel);
    RELEASE_SAFELY(_badge);
    RELEASE_SAFELY(_longPressGes);
//    RELEASE_SAFELY(_panGes);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = NO;
        
        [self initViewComponent];
        [self initGestureRecoginzer];
        
//        self.padding = UIEdgeInsetsMake(15, 15, 0, 0);
    }
    return self;
}

- (id)initWithImage:(UIImage *)image title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.image = image;
        self.title = title;
        
        [self._bodyButton setImage:self.image forState:UIControlStateNormal];
        [self._nameLabel setText:self.title];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWidth = self.bounds.size.width - self.padding.left - self.padding.right;
    
    self._bodyButton.frame = CGRectMake(self.padding.left, self.padding.top, imageWidth, imageWidth);
    
    CGSize labelSize = [self.title sizeWithFont:self._nameLabel.font];
    self._nameLabel.frame = CGRectMake(0, 
                                       self.bounds.size.height - labelSize.height - self.padding.bottom,
                                       self.bounds.size.width, 
                                       labelSize.height);
    
    CGRect badgeFrame = self._badge.frame;
    badgeFrame.origin = CGPointMake(self.bounds.size.width - badgeFrame.size.width - 1, 4);
    self._badge.frame = badgeFrame;
    
    if (self._deleteButton && self.canDelete)
    {
        self._deleteButton.frame = CGRectMake(0, 0, 20, 20);
    }
}

#pragma mark - private

- (void)initViewComponent
{
    self._bodyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self._bodyButton.contentMode = UIViewContentModeCenter;
    self._bodyButton.userInteractionEnabled = NO;
    
    self._nameLabel = [[[UILabel alloc] init] autorelease];
    self._nameLabel.numberOfLines = 1;
    self._nameLabel.textAlignment = UITextAlignmentCenter;
    self._nameLabel.font = [UIFont systemFontOfSize:10.0];
    self._nameLabel.textColor = [UIColor geminiColor_102_102_102];
    self._nameLabel.backgroundColor = [UIColor clearColor];
    
    self._badge = [[[HomeBadgeView alloc] init] autorelease];
    self._badge.hideWhenZero = YES;
    self._badge.badgeValue = 0;
    self._badge.font = [UIFont boldSystemFontOfSize:12.0];
    
    [self addSubview:self._bodyButton];
    [self addSubview:self._nameLabel];
    [self addSubview:self._badge];
}

- (void)initGestureRecoginzer
{
    UILongPressGestureRecognizer *longPressGes = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)] autorelease];
    longPressGes.minimumPressDuration = 0.5;
    longPressGes.enabled = !self.editing;
    longPressGes.cancelsTouchesInView = NO;

    [self addGestureRecognizer:longPressGes];
    self.longPressGes = longPressGes;
}

- (void)addDeleteButton
{
    self._deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *crossImage = [UIImage imageForRetina:@"home_app_delete_20_20" ofType:@"png"];
    [self._deleteButton setImage:crossImage forState:UIControlStateNormal];
    [self._deleteButton addTarget:self action:@selector(tapDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self._deleteButton];
}

- (void)removeDeleteButton
{
    [self._deleteButton removeFromSuperview];
    self._deleteButton = nil;
}

- (void)setEditingMode:(BOOL)editing
{    
    if (editing)
    {
        self.longPressGes.enabled = NO;
        [self addDeleteButton];
    }
    else
    {
        self.longPressGes.enabled = YES;
        [self removeDeleteButton];
    }
}

- (void)setDraggingMode:(BOOL)dragging
{
    if (dragging)
    {
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.7;
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if ([self.delegate respondsToSelector:@selector(launcherViewButton:didLongPress:)]) 
    {
        [self.delegate launcherViewButton:self didLongPress:longPress];
    }
}

- (void)tapDeleteButton
{
    if ([self.delegate respondsToSelector:@selector(launcherViewButtonDidTapDeleteButton:)]) 
    {
        [self.delegate launcherViewButtonDidTapDeleteButton:self];
    }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!_editing)
    {
//        self._blackMask.alpha = 0.2;
        self.alpha = 0.7;
    }
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.alpha = 1.0;
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.alpha = 1.0;
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

#pragma mark - property

- (void)setImage:(UIImage *)image
{
    [self._bodyButton setImage:image forState:UIControlStateNormal];
}

- (UIImage *)image
{
    return self._bodyButton.imageView.image;
}

- (void)setTitle:(NSString *)title
{
    self._nameLabel.text = title;
}

- (NSString *)title
{
    return self._nameLabel.text;
}

- (void)setEditing:(BOOL)editing
{
    if (_editing != editing)
    {
        _editing = editing;
        [self setEditingMode:editing];
    }
}

- (BOOL)editing
{
    return _editing;
}

- (void)setDragging:(BOOL)dragging
{
    if (_dragging != dragging) 
    {
        _dragging = dragging;
        [self setDraggingMode:dragging];
    }
    
}

- (BOOL)dragging
{
    return _dragging;
}

- (void)setBadgeNumber:(NSInteger)badgeNumber
{
    if (_badgeNumber != badgeNumber)
    {
        _badgeNumber = badgeNumber;
        self._badge.badgeValue = badgeNumber;
    }
}

- (NSInteger)badgeNumber
{
    return _badgeNumber;
}

@end
