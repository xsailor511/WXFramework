# Framework 打包测试工程
新建一个cocoa touch framework(ios) 项目

1.xcode会为你自动创建一个头文件，和工程名一致，本项目就是WXFramework.h, 这头文件用来包含你所有的头文件的，引用的时候，只引用这一个就行了

* 如果你不引用这个统一的头文件，而是引用具体的某个头文件，就会报出warning：missing submodules

2.和.a静态库类似，需要设置Build Phases里的东西

* 设置选项Headers,添加想要公开的头文件到Public 子项下
* Compile Sources 里添加相应的.m文件

3.build即可，设置iPhone 7和Generic iOS Device，Debug和Release模式产生不同的framework文件

* 设置iPhone 7 为虚拟机提供framework, Generic iOS Device为真机提供framework
* 在菜单路径Product==>Scheme==>Edit Scheme,在Run 标签下设置 Build configuration 为Debug或者Release

4.可以新建一个Aggregate类型的target，然后粘贴本例子中的script代码，选择本MyAggregate，点击运行，就能自动生成适用于真机和虚拟机的framework文件

* Aggregate 主要用来合并两个项目
* 选中MyAggregate，选择Build Phases ，点击左上角“+”，新增一个run script，就可以粘贴代码了
* 更多合并不同的架构包的信息参考[http://devonios.com/xcode-lipo-framework.html](http://devonios.com/xcode-lipo-framework.html)
* [xcode build时用到了环境变量](http://www.cnblogs.com/Ricky81317/archive/2013/03/08/2950156.html)

5.新增bundle资源文件包

* 新增target ==> macos ==>Framework and Library ==> Bundle，命名为WXFrameworkResource
* 在设置界面，选中刚刚新建的target，WXFrameworkResource，设置Build Setting ==> Base SDK ,Supported Platforms为ios
* 在Build Phases 界面，copy Bundle Resources 下，将xib，storyboard 和Images.xcassets文件添加进去
* 在Build Setting 里搜索 product name ,设置其值为$(PROJECT_NAME)，与项目名称一致
* 选中target WXFramework,设置其Build Phases ==> Target Dependencies ，新增一个WXFrameworkResource，这样buildFramework时同时就会build好Bundle
* 默认情况下，有两种resolutions的图片可以产生一些有趣的现象。例如，当你导入一个retina @2x版本的图片时，普通版的和Retina版的将会合并成一个多resolution的TIFF（标签图像文件格式，Tagged Image File Format）。这不是一件好事。搜索hidpi将COMBINE_HIDPI_IMAGES设置为NO。
* 参考[http://www.cocoachina.com/ios/20150127/11022.html](http://www.cocoachina.com/ios/20150127/11022.html)

6.使用本项目生成的.framework的测试项目[TestWXFramework](https://github.com/xsailor511/TestWXFramework)
