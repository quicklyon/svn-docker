<!-- 这里写应用的【环境变量信息】 -->

SVNAdmin默认的用户名是 `admin`，密码是 `pass4You` ，你可以在首次运行容器镜像时通过环境变量来设置管理员名称与密码，以下是一些支持的环境变量：


| 变量名 | 默认值 | 说明 |
| --- | --- | --- |
| `ADMIN_USER` | `admin` |  svn管理员用户名 |
| `ADMIN_PASSWORD` | `pass4You` | svn管理员密码 |


示例:

```sh
...
-e ADMIN_USER=manager
-e ADMIN_PASSWORD=justforTest
```
