## SwiftTableView
### 环境
Xcode 12.5 + Swift 5.4

最低支持 iOS 13.0

### build方式
1. 切到develop分支
2. 进入SwiftTableView文件夹，pod install
3. 打开SwiftTableView.xcworkspace
4. 选择模拟器
5. run

### 设计思路 && 功能
因为图片可能有多张，且文案高度不确定，为了确保列表滑动性能，因此采取了如下措施：
1. 缓存列表高度，控件布局信息
2. 区分不同类型的cell，滑动过程中不添加子控件，只隐藏/显示
3. 列表页面最多显示9张图片，超过9张显示more
4. 列表页面最多5行文字
5. 详情页面使用collectionView，可以显示多张图片、多行文字
6. 图片框架使用的是AlamofireImage，图片缓存方式是LRU
7. 单张图片时，设置了最大值，确保图片可以正确显示
8. 用从本地读数据的方式模拟了网络请求，支持下拉刷新、上滑刷新
9. 支持仅有文字、仅有图片、既有图片又有文字

### TODO
1. 无网络、无数据
2. 国际化
3. text-link



