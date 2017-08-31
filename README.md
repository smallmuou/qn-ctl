# qn-cli

> 七牛云文件操作命令行集合，类似于linux文件操作
> ![示例](/path/to/img.jpg "示例")
>

<link rel="stylesheet" type="text/css" href="http://oltdjo9l7.bkt.clouddn.com/asciinema-player.css" />
<script src="http://oltdjo9l7.bkt.clouddn.com/asciinema-player.js"></script>
<asciinema-player src="res/qnctl.json" autoplay preload></asciinema-player>

## 安装
1. 在安装此命令之前，请先安装[qrsctl](https://developer.qiniu.com/kodo/tools/1300/qrsctl)
```bash
mv qrsctl-xxx qrsctl
chmod +x qrsctl
sudo mv qrsctl /usr/local/bin
```

2. 安装该命令集
```
git clone https://github.com/smallmuou/qn-ctl
cd qn-cli
sudo /bin/bash install.sh
```

## 使用

每个命令都提供了帮助说明，只要敲下`-h`就可以查阅帮助，如

```bash
qn -h
qn ls -h
```
PS：在使用ls、mkdir等命令之前，请先配置AccessKey和SecretKey

```bash
qn config your-ak your-sk
```

## 已支持的命令集

|命令|功能描述|例子
|:--|:--|:--
|config|配置AccessKey和SecretKey| qn config xyour-ak your-sk
|ls|列出bucket或文件|qn ls
|mkdir|创建bucket|qn mkdir 1 2 3
|rm|删除文件（不支持删除bucket）|qn rm 1/12
|get|下载文件至本地
|put|上传本地文件至七牛
|mv|移动或重命名文件（不支持bucket）|qn mv 1/* 2
|cp|拷贝文件|qn cp 1/* 2

## 名称说明

|名词|功能描述
|:--|:--
|bucket|相当于目录
|file|相当于文件
|AccessKey|访问密钥，可从七牛个人安全中心获取
|SecretKey|安全密钥，可从七牛个人安全中心获取
