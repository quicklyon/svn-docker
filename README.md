<!-- 该文档是模板生成，手动修改的内容会被覆盖，详情参见：https://github.com/quicklyon/template-toolkit -->
# QuickOn svn-server 应用镜像

![GitHub Workflow Status (event)](https://img.shields.io/github/actions/workflow/status/quicklyon/svn-server-docker/docker.yml?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/svn-server?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/svn-server?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/svn-server-docker?style=flat-square)

> 申明: 该软件镜像是由QuickOn打包。在发行中提及的各自商标由各自的公司或个人所有，使用它们并不意味着任何从属关系。

## 快速参考

- 通过 [渠成软件百宝箱](https://www.qucheng.com/app-install/install-svn-server.html) 一键安装 **svn-server**
- [Dockerfile 源码](https://github.com/quicklyon/svn-docker)
 - [Apache® Subversion® 官网](https://subversion.apache.org/)

## 一、关于 svn-server

<!-- 这里写应用的【介绍信息】 -->

[Apache® Subversion®](https://subversion.apache.org/)  Subversion 是一个开源版本控制系统。 Subversion 项目和软件由 CollabNet, Inc. 于 2000 年创立，在过去十年中取得了令人难以置信的成功。 Subversion 已经并将继续在开源领域和企业界得到广泛采用。

![screenshots](https://raw.githubusercontent.com/quicklyon/svn-docker/quickon/.template/svn_screenshots.png)

<!-- 这里写应用的【附加信息】 -->

下面列出的功能是假设您对版本控制是什么以及版本控制系统一般如何工作有基本的了解。如果您正在寻找的某个功能未在此列表中列出，请随时在我们的项目邮件列表中询问 - 也许我们只是没有想到将其列出在这里。如果 Subversion 确实缺少您需要的功能，您的反馈将帮助我们改进 Subversion，同时，也许我们可以通过 Subversion 所具有的功能来帮助您满足您的需求。

### 特性

- **大多数 CVS 功能**
CVS是一个比较基础的版本控制系统。在大多数情况下，Subversion 已经匹配或超过了 CVS 的功能集，这些功能继续应用于 Subversion 的特定设计中。

- **目录是有版本的**
Subversion 将目录版本化为一流对象，就像文件一样。

- **复制、删除和重命名均受版本控制**
复制和删除是版本化操作。重命名也是一种版本化操作，尽管有一些怪癖。

- **自由格式版本化元数据（“属性”）**
Subversion 允许将任意元数据（“属性”）附加到任何文件或目录。这些属性是键/值对，并且像它们附加的对象一样进行版本控制。 Subversion 还提供了一种将任意键/值属性附加到修订版（即已提交的变更集）的方法。这些属性没有版本控制，因为它们将元数据附加到版本空间本身，但它们可以随时更改。

- **原子提交**
在整个提交成功之前，提交的任何部分都不会生效。修订号是针对每个提交的，而不是针对每个文件的，并且提交的日志消息附加到其修订版本，而不是冗余地存储在受该提交影响的所有文件中。

## SVN应用说明

SVN应用，基于 **Alpine Linux** 系统和 S6 进程管理服务组成 (了解更多信息，[参见](https://github.com/smebberson/docker-alpine) )。包含了 [SVNAdmin](https://github.com/mfreiholz/iF.SVNAdmin) Web管理端服务，可以通过浏览器进行用户创建，仓库创建，权限配置等操作。支持通过 **WebDav 协议** (http://) , 和 **snv 协议** (svn://) 访问服务。

#### 本地运行

通过如下命令运行镜像：

```
docker run  -d --name svn-server \
            -p 80:80 \
            -p 3690:3690 \
            -v <宿主机目录>:/data \
            -v hub.zentao.net/app/svn-server
```

- `/data` 目录存储了仓库web管理服务的配置文件。

## 二、支持的版本(Tag)

由于版本比较多,这里只列出最新的5个版本,更详细的版本列表请参考:[可用版本列表](https://hub.docker.com/r/easysoft/svn-server/tags/)

<!-- 这里是镜像的【Tag】信息，通过命令维护，详情参考：https://github.com/quicklyon/template-toolkit -->
- [latest , 1.14.2](https://subversion.apache.org/docs/release-notes/1.14.html)

## 三、获取镜像

推荐从 [Docker Hub Registry](https://hub.docker.com/r/easysoft/svn-server) 拉取我们构建好的官方Docker镜像。国内用户，请从我们自建的镜像仓库拉取。

```bash
docker pull easysoft/svn-server:latest

# 国内用户
docker pull hub.zentao.net/app/svn-server:latest
```

如需使用指定的版本，可以拉取一个包含版本标签的镜像，在Docker Hub仓库中查看 [可用版本列表](https://hub.docker.com/r/easysoft/svn-server/tags/)

```bash
docker pull easysoft/svn-server:[TAG]

# 国内用户
docker pull hub.zentao.net/app/svn-server:[TAG]
```

## 四、持久化数据

如果你删除容器，所有的数据都将被删除，下次运行镜像时会重新初始化数据。为了避免数据丢失，你应该为容器提供一个挂在卷，这样可以将数据进行持久化存储。

为了数据持久化，你应该挂载持久化目录：

- /data 持久化数据

如果挂载的目录为空，首次启动会自动初始化相关文件

```bash
$ docker run -it \
    -v $PWD/data:/data \
docker pull easysoft/svn-server:latest
```

或者修改 docker-compose.yml 文件，添加持久化目录配置

```bash
services:
  svn-server:
  ...
    volumes:
      - /path/to/svn-persistence:/data
  ...
```

## 五、环境变量

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

## 六、运行

### 6.1 单机Docker-compose方式运行

```bash
# 启动服务
make run

# 查看服务状态
make ps

# 查看服务日志
docker-compose logs -f svn-server

```

<!-- 这里写应用的【make命令的备注信息】位于文档最后端 -->

**说明:**

- 启动成功后，打开浏览器输入 `http://<你的IP>` 访问管理后台。
- [VERSION](https://github.com/quicklyon/svn-docker/blob/main/VERSION) 文件中详细的定义了Makefile可以操作的版本。
- [docker-compose.yml](https://github.com/quicklyon/svn-docker/blob/main/docker-compose.yml)。

## 七、版本升级

<!-- 这里是应用的【应用升级】信息，通过命令维护，详情参考：https://github.com/quicklyon/doc-toolkit -->
容器镜像已为版本升级做了特殊处理，当检测数据（数据库/持久化文件）版本与镜像内运行的程序版本不一致时，会进行数据库结构的检查，并自动进行数据库升级操作。

因此，升级版本只需要更换镜像版本号即可：

> 修改 docker-compose.yml 文件

```diff
...
  snv-server:
-    image: hub.zentao.net/app/svn-server:1.13
+    image: hub.zentao.net/app/svn-server:1.14
    container_name: svn-server
...
```

更新服务

```bash
# 是用新版本镜像更新服务
docker-compose up -d

# 查看服务状态和镜像版本
docker-compose ps
```