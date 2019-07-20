# showks installer

## prepare

### env
`showks.env` に適切な値を書き込みます  

### tls cert

`tls.crt` `tls.key` `github.key` を `cert/` に配置します

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
