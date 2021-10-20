# 构建编译文件
FROM golang:1.17 as builder
# 拷贝项目文件到镜像中
COPY . /bin/app
# 设置命令工作目录
WORKDIR /bin/app
# 执行命令编译项目文件
RUN go build -o /bin/app/web-app .

# 构建运行时文件
FROM alpine:3.13
# 添加作者
LABEL author=pingwazi
# 设置工作目录
WORKDIR /bin/app
# 从上一阶段中拷贝可执行文件
COPY --from=builder /bin/app/web-app /bin/app/web-app
# 声明暴露的端口
EXPOSE 8080/tcp
# 调整动态链接地址
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
# 启动服务
ENTRYPOINT [ "/bin/app/web-app" ]