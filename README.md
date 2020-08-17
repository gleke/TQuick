
# TQuick 拿来即用，为简单而生

**MIT License**

是一款基于Qt(Quick)跨平台技术采用自身模块规范编写的轻量级QML UI框架（基于[`Toou`](http://www.toou.net)团队开发的[`Toou-2d`](https://github.com/ShowFL/Toou-2D)框架开发），遵循Qt书写与组织形式门槛极低无需深入学习简单易用可[`拿来即用`](#)，丰富的控件模块适合界面的快速开发，让程序人员拥有更多的精力来实现业务逻辑与算法。

* 统一交互规范，丰富的Ui控件[`几十种常用控件`](#)放弃了Qt Controls 及 Controls 2 来提高性能；

* 完善的主题系统，业务逻辑与界面主题设计分离，可通过简单修改变量[`自定义主题`](#)皮肤。灵活的多主题皮肤绑定机制、在不需要重启App即实现[`一键换肤`](#)；

* json主题文件配置规则与每一个控件融合。可在应用内配置也可在应用外动态扩展配置。可自动生成App模板json主题文件，配置多主题只需要基于模板主题文件修改即可。支持动态修改主题文件，App实时更新显示功能；

* 框架自动化安装支持动态库、静态库多模式编译。使用方便更安全更自由；

* 提供丰富Demo、全面的帮助文档，Api查阅快速方便。[`项目必备`](#)开源框架；

* 已经集成最新版 [`Font Awesome 4.7`](#)



## 运行 Example 快速开始

> 需要Qt 5.9.0 或更高版本。
> 1. 将项目clone到本地使用 Qt creator 打开 TQuick.pro
> 2. 构建（先构建后运行）
> 3. 运行即可即可看到demo 预览效果。

*支持 macOS ,Windows 构建，可发布到 macOS,Windows,iOS,Android等多平台。*



## 主题

首先TQuick的皮肤数据全部定义在 json 文件中，这些 json 文件可以写在应用内也可以是应用的外部。通过修改  json 对象属性及简单通用的规则（类似qss规则）即可实现完美的皮肤制作。

TThemeBinder控件与主题样式数据绑定在一起。废话不说看代码，如下:

```
//!当主题发展改变，Rectangle也会改变他的 color , width
//!同时不会打破 width 的原有绑定。
Rectangle {
    id: rect
    width: parent.width
    height: 100
    color: "red"

    TThemeBinder {
        id: theme
        className: "MRect"
        property alias color: rect.color
        property alias width: rect.width
        property alias height: rect.height
    }
}
```



## 设备运行测试

| 平台&编译器                        | 结果 |
| ---                               | ---  |
| Windows 10 MSVC2017 32bit         | OK   |
| Windows 10 MSVC2017 64bit         | OK   |
| Windows 10 MinGW 7.3.0 32bit      | OK   |
| Windows 10 MinGW 7.3.0 64bit      | OK   |
| MacOs 10.15.6 Clang 11.0.3 64bit  | OK   |
| Deepin 15.11 Clang 3.8.1 64bit    | OK   |
| Deepin 15.11 GCC 6.3.0 64bit      | OK   |