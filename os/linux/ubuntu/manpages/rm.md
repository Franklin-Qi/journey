# rm 删除命令

## 删除除了某个文件之外的所有文件
shopt 启用了 shell 选项 extglob，支持 !
> shopt -s extglob

> rm -rf !(file)
> rm -rf !(file1 | file2)

