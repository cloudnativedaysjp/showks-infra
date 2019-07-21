# showks installer

## prepare

### env
`showks.env` に適切な値を書き込みます  

### tls cert

`<domain>.crt` `<domain>.key` 及び `github.key` を `cert/` に配置します  
domain の crt と key は production/staging/common の 3 種類合計 6 つのファイルが配置される想定です

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
