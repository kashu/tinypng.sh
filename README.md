## PNG/JPG图片高级有损压缩（Advanced lossy compression for PNG/JPG images）
* 使用此脚本前需要连接互联网 (Internet connectivity is required before use this shell.)
* Get API_KEY: https://tinypng.com/developers

## 选项（Options）
```
-r|-R        Recursively compress images
-h|--help    Print help info
```

## 使用方法（Usage）
* ./tinypng.sh [-r|-R] [/path/to/img]

```
e.g.
   ./tinypng.sh
   ./tinypng.sh /home/kashu/Pictures
   ./tinypng.sh -r
   ./tinypng.sh -r /path/to/your/images
```

## 说明（Instructions）
- 默认只压缩当前路径（未指定路径时）或指定路径下的图片，只有加上-r或-R时才会执行递归形式的压缩
- 文件后缀名不区分大小写（即：Jpg, jpG, JPG, PnG, PNG等都可接受），压缩后的文件名统一变成.png或.jpg
- 原图片文件会移动到$backup目录中（即：/tmp/img_original_`date +%Y%m%d_%H%M%S`）
- 当执行递归压缩且碰到有同名的文件时，重名的原文件会自动被更名，并移动到$backup目录中
- 可以对相同图片进行反复压缩——反正你可以反复执行此脚本来反复压缩你的图片
- tinypng的压缩能力不是一般的无损或有损压缩工具能媲美的（此处的工具不仅指：optipng/imagemagick/trimage/jpegtran）
- 每月只能免费压缩500张图片。（The first 500 compressions each month are free.）对我个人而言，绰绰有余。

## 效果示例（Sample）
![](http://ww1.sinaimg.cn/large/9c4ddab1jw1f0hzqvc734j20gj06z40c.jpg)
