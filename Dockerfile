##FROM：指定基础镜像，必须为第一个命令
##格式：
##　　FROM <image>
##　　FROM <image>:<tag>
##　　FROM <image>@<digest>
##示例：
##　　FROM mysql:5.6
##注：
##　　tag或digest是可选的，如果不使用这两个值时，会使用latest版本的基础镜像
#FROM java:8
#
##MAINTAINER: 维护者信息
##
##格式：
##    MAINTAINER <name>
##示例：
##    MAINTAINER Jasper Xu
##    MAINTAINER sorex@163.com
##    MAINTAINER Jasper Xu <sorex@163.com>
#MAINTAINER: shanshuan 826763562@qq.com
#
#
#
#
##RUN：构建镜像时执行的命令
##
##复制代码
##RUN用于在镜像容器中执行命令，其有以下两种命令执行方式：
##shell执行
##格式：
##    RUN <command>
##exec执行
##格式：
##    RUN ["executable", "param1", "param2"]
##示例：
##    RUN ["executable", "param1", "param2"]
##    RUN apk update
##    RUN ["/etc/execfile", "arg1", "arg1"]
##注：
##　　RUN指令创建的中间镜像会被缓存，并会在下次构建中使用。如果不想使用这些缓存镜像，可以在构建时指定--no-cache参数，如：docker build --no-cache
#
#
##ADD：将本地文件添加到容器中，tar类型文件会自动解压(网络压缩资源不会被解压)，可以访问网络资源，类似wget
##
##复制代码
##格式：
##    ADD <src>... <dest>
##    ADD ["<src>",... "<dest>"] 用于支持包含空格的路径
##示例：
##    ADD hom* /mydir/          # 添加所有以"hom"开头的文件
##    ADD hom?.txt /mydir/      # ? 替代一个单字符,例如："home.txt"
##    ADD test relativeDir/     # 添加 "test" 到 `WORKDIR`/relativeDir/
##    ADD test /absoluteDir/    # 添加 "test" 到 /absoluteDir/
#
#
##COPY：功能类似ADD，但是是不会自动解压文件，也不能访问网络资
#
##CMD：构建容器后调用，也就是在容器启动时才进行调用。
##
##复制代码
##格式：
##    CMD ["executable","param1","param2"] (执行可执行文件，优先)
##    CMD ["param1","param2"] (设置了ENTRYPOINT，则直接调用ENTRYPOINT添加参数)
##    CMD command param1 param2 (执行shell内部命令)
##示例：
##    CMD echo "This is a test." | wc -
##    CMD ["/usr/bin/wc","--help"]
##注：
## 　　CMD不同于RUN，CMD用于指定在容器启动时所要执行的命令，而RUN用于指定镜像构建时所要执行的命令。
#RUN mvn clean
#RUN mvn install
#
## 暴露端口
#EXPOSE 8080
#
## docker入口文件
#CMD ["java", "-jar", "target/sjk-web-1.0.0.jar"]
## 构建和运行
## 最好激活test，或配置成指定ip，否则容器无法找到mysql或redis地址
## 切记不要试图在容器中安装mysql或redis，这是非常不好的习惯
## 如果是个人独占则必须加上自己名字来区分如张大龙使用则ebi-burcent-app改为ebi-burcent-app-zdl
## docker build -t ebi-burcent-app .
## docker run -it --rm --name running-ebi-burcent-app -p 8081:8080 ebi-burcent-app




FROM java:8
FROM maven
VOLUME /tmp
# 指定工作区间
WORKDIR /docker_demo

# 复制文件(可使用.dockerignore)
COPY . /docker_demo
RUN mvn clean
RUN mvn install
# 暴露端口
EXPOSE 8080
# docker入口文件
CMD ["java", "-jar", "target/docker_demo-0.0.1-SNAPSHOT.jar"]
# 构建和运行
# 最好激活test，或配置成指定ip，否则容器无法找到mysql或redis地址
# 切记不要试图在容器中安装mysql或redis，这是非常不好的习惯
# 如果是个人独占则必须加上自己名字来区分如张大龙使用则ebi-burcent-app改为ebi-burcent-app-zdl
# docker build -t app .
# docker run -it --rm --name running-app -p 8081:8080 app
