# showks installer

## prepare

`showks.env` に適切な値を書き込みます  
その後 `make install` で適用します

## apply

```bash
$ vi showks.env
$ set -a
$ . showks.env

$ make prepare
# ./staging に適用される manifest が用意されます

$ make dry-run
# apply --dry-run で確認できます

$ make install
# 実際に apply します
```
