# CYPlayer

和程序员本身一样，都在默默地发光！

## 通过cocoapods安装播放器到项目

```
pod 'CYPlayer'
```

## 播放器基本特性

- [x] ✅ 支持动态帧率控制，适配各种性能的机型，随系统性能动态调节解码帧率;

- [x] ✅ 动态内存控制，适配小内存的iPhone，防止在老设备crash；

- [x] ✅ 基于Masonry的AutoLayout；

- [x] ✅ 拿来可用，带控制交互界面，可自定义, 默认提供了变速播放功能, 清晰度选择功能；

- [x] ✅ 音频采用Sonic优化，支持倍速播放；

- [x] ✅ 基于CYFFMpeg动态库；

- [x] ✅ 支持x86_64模拟器调试和armv7/arm64真机调试；

- [x] ✅ Enable Bitcode=YES；

- [x] ✅ 开箱即用。


## 关于解码动态库CYFFmpeg

- [x] ✅ CYFFmpeg可以通过CocoaPods进行安装；

- [x] ✅ 构建为动态库版本；

- [x] ✅ 支持Samba协议，多线程优化；

- [x] ✅ 支持Http、Https(CYFFmpeg 0.3.1)协议；

- [x] ✅ 支持RTMP、HLS、RTSP协议；

- [x] ✅ 基于ffmpeg 3.4.2；

- [x] ✅ 支持ffmpeg命令行方式调用；

```objective-c
//ffmpeg -i Downloads.mp4 -r 1 -ss 00:20 -vframes 1 %3d.jpg
char* a[] = {
    "ffmpeg",
    "-ss",
    timeInterval,
    "-i",
    movie,
    "-f",
    "image2",
    "-r",
    "25",
    "-vframes",
    "1",
    outPic
};
//加锁
dispatch_semaphore_wait([CYGCDManager sharedManager].av_read_frame_lock, DISPATCH_TIME_FOREVER);
int result = ffmpeg_main(sizeof(a)/sizeof(*a), a);
dispatch_semaphore_signal([CYGCDManager sharedManager].av_read_frame_lock);
```

- [x] ✅ 支持x86_64模拟器、armv7/arm64真机运行；

- [x] ✅ Enable Bitcode=YES；

- [x] ✅ 开箱即用。


[CYFFmpeg-基于ffmpeg的iOS动态库](https://github.com/yellowei/CYFFmpeg)




## 示例动图


![prew-1.gif](https://raw.githubusercontent.com/yellowei/CYPlayer/master/prew-1.gif)

![prew-2.gif](https://raw.githubusercontent.com/yellowei/CYPlayer/master/prew-2.gif)


## 简单的代码

```Objective-C

#import "ViewController.h"
#import <CYPlayer/CYPlayer.h>
#import <Masonry.h>

@interface ViewController ()
{
    CYFFmpegPlayer * vc1;// 全局化, 便于控制
}

@property (nonatomic, strong) UIView * contentView; //给一个contentView承载播放器的视图, 也可直接add到当前控制器的self.view
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * contentView = [UIView new];
    contentView.backgroundColor = [UIColor blackColor];
    self.contentView = contentView;
    [self.view addSubview:contentView];
    //设置自动布局
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.leading.trailing.offset(0);
        make.height.equalTo(contentView.mas_width).multipliedBy(9.0 / 16.0);
    }];
    
    // 初始化播放器
    vc1 = [CYFFmpegPlayer movieViewWithContentPath:@"https://vodplay.yayi360.com/liveRecord/46eca58c0ccf5b857fa76cb3c9fea487/dentalink-vod/515197938314592256/2020-08-17-12-18-39_2020-08-17-12-48-39.m3u8" parameters:nil];
    [vc1 settingPlayer:^(CYVideoPlayerSettings *settings) {
        settings.definitionTypes = CYFFmpegPlayerDefinitionLLD | CYFFmpegPlayerDefinitionLHD | CYFFmpegPlayerDefinitionLSD | CYFFmpegPlayerDefinitionLUD;
        settings.enableSelections = YES;
        settings.setCurrentSelectionsIndex = ^NSInteger{
            return 3;//假设上次播放到了第四节
        };
        settings.nextAutoPlaySelectionsPath = ^NSString *{
            return @"https://vodplay.yayi360.com/liveRecord/46eca58c0ccf5b857fa76cb3c9fea487/dentalink-vod/515197938314592256/2020-08-17-12-18-39_2020-08-17-12-48-39.m3u8";
        };
        //        settings.useHWDecompressor = YES;
        //        settings.enableProgressControl = NO;
    }];

    vc1.autoplay = YES;
    vc1.generatPreviewImages = NO;
    [self.contentView addSubview:vc1.view];
    //播放器视图添加到父视图之后,一定要设置播放器视图的frame,不然会导致opengl无法渲染以致播放失败
    [vc1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.top.bottom.offset(0);
        make.width.equalTo(vc1.view.mas_height).multipliedBy(16.0 / 9.0);
    }];
}

- (void)dealloc
{
    [vc1 stop];//记得要停止播放
}


@end
```

## 注意

```
因为新版Xcode不再提供32位模拟器

CYFFmpeg0.3.1开始, 编译架构取消了i386, 仍然支持x86_64模拟器和所有真机

不再需要设置"OTHER_LDFLAGS"的"-read_only_relocs suppress"
```


基于CYFFmpeg0.2.2版本以及之前版本的需要做以下事情

```
pod安装CYPlayer后,如果遇到xcode无法调试的问题

请到xocde工程Pod目录下CYPlayer找到"Support Files/CYPlayer.xcconfig"文件

删除OTHER_LDFLAGS中的-read_only_relocs suppress, 尝试真机能否运行
```


## 相关阅读


[《iOS中基于ffmpeg开发的播放器打开多个samba链接的解决方案》](https://www.jianshu.com/p/2838b9ddecaf)

[《ffmpeg中samba网络协议的兼容分析(一)》](https://www.jianshu.com/p/ada84499f386)

[《ffmpeg中samba网络协议的兼容分析(一)》](https://www.jianshu.com/p/06b5794a7213)

[《ffmpeg中samba网络协议的兼容分析(一)》](https://www.jianshu.com/p/ada84499f386)


