{{WARNING}}
# QuickOn {{APP_NAME}} 应用镜像

![GitHub Workflow Status (event)](https://img.shields.io/github/actions/workflow/status/quicklyon/svn-docker/docker.yml?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/{{app_name}}?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/{{app_name}}?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/svn-docker?style=flat-square)

> 申明: 该软件镜像是由QuickOn打包。在发行中提及的各自商标由各自的公司或个人所有，使用它们并不意味着任何从属关系。

## 快速参考

- 通过 [渠成软件百宝箱]({{APP_INSTALL_DOC_URL}}) 一键安装 **{{APP_NAME}}**
- [Dockerfile 源码]({{APP_DOCKERFILE_GIT_URL}})
 - [Apache® Subversion® 官网]({{APP_HOME}})

## 一、关于 {{APP_NAME}}

{{APP_DESC}}

{{APP_EXTRA_INFO}}

## 二、支持的版本(Tag)

由于版本比较多,这里只列出最新的5个版本,更详细的版本列表请参考:[可用版本列表]({{APP_DOCKER_HUB_TAG_URL}})

{{APP_DOCKER_TAG}}

## 三、获取镜像

推荐从 [Docker Hub Registry]({{APP_DOCKER_HUB_URL}}) 拉取我们构建好的官方Docker镜像。国内用户，请从我们自建的镜像仓库拉取。

```bash
docker pull easysoft/{{APP_DOCKER_IMAGE_NAME}}:latest

# 国内用户
docker pull hub.zentao.net/app/{{APP_DOCKER_IMAGE_NAME}}:latest
```

如需使用指定的版本，可以拉取一个包含版本标签的镜像，在Docker Hub仓库中查看 [可用版本列表]({{APP_DOCKER_HUB_TAG_URL}})

```bash
docker pull easysoft/{{APP_DOCKER_IMAGE_NAME}}:[TAG]

# 国内用户
docker pull hub.zentao.net/app/{{APP_DOCKER_IMAGE_NAME}}:[TAG]
```

## 四、持久化数据

如果你删除容器，所有的数据都将被删除，下次运行镜像时会重新初始化数据。为了避免数据丢失，你应该为容器提供一个挂在卷，这样可以将数据进行持久化存储。

为了数据持久化，你应该挂载持久化目录：

- /data 持久化数据

如果挂载的目录为空，首次启动会自动初始化相关文件

```bash
$ docker run -it \
    -v $PWD/data:/data \
docker pull easysoft/{{APP_DOCKER_IMAGE_NAME}}:latest
```

或者修改 docker-compose.yml 文件，添加持久化目录配置

```bash
services:
  {{APP_NAME}}:
  ...
    volumes:
      - /path/to/svn-persistence:/data
  ...
```

## 五、环境变量

{{APP_ENVS}}

## 六、运行

### 6.1 单机Docker-compose方式运行

```bash
# 启动服务
make run

# 查看服务状态
make ps

# 查看服务日志
docker-compose logs -f {{APP_DOCKER_IMAGE_NAME}}

```

{{MAKE_EXTRA_INFO}}
- [VERSION]({{APP_DOCKERFILE_GIT_URL}}/blob/main/VERSION) 文件中详细的定义了Makefile可以操作的版本。
- [docker-compose.yml]({{APP_DOCKERFILE_GIT_URL}}/blob/main/docker-compose.yml)。

## 七、版本升级

{{APP_UPDATE}}