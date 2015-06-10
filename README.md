jaguchi
===============

>_日本は蛇口をひねればきれいな水がでます。_

>_データにおいてもそうありたいのです。_

>_所沢義男_

## 使い方
jaguchi関数にapiの名前を指定してその他のパラメータを指定することで結果を受け取ります。

```r
jaguchi(apiname, その他のパラメータ)
```

利用できるwebAPIについては順次追加していく予定です。

webAPIを利用するために必要なパッケージがインストールされていない場合は、その旨案内が出るので`devtools::install_github()`などでインストールしてください。

なお、金融データの取得にはteramonagi氏のRFinanceJパッケージを利用しています。多謝。

### slideshareのスライドの情報を取得する
slideshareのスライド情報取得には認証が必要なので事前にKEYとSECRETを取得しておいてください。
```r
jaguchi("slideshare", url="http://www.slideshare.net/dichika/saku110716", 
　　　　key="取得したCONSUMER_KEY", secret="取得したCONSUMER_SECRET")
```

### speakerdeckのスライドの情報を取得する
speakerdeckのスライド情報取得はURLのみでOKです。

```r
jaguchi("speakerdeck", url="https://speakerdeck.com/dichika/tokyor-extra-number-1")
```

### 指定したURLのはてなブックマークの数を取得する
情報を取得したいURLを指定します。
```r
jaguchi("hatenab", "http://d.hatena.ne.jp/dichika/20140503/p1")
```

### 指定したユーザのgithub上の進捗を取得する
いわゆるgithub上の芝生です。
```r
jaguchi("sinchokur", username="dichika")
```

### Yahoo!Financeから株価を取得する
以下はみずほフィナンシャルグループの株価を取得する例です。
teramonagi氏のRFinanceJを利用しています。
```r
jaguchi("yfj", code="8411.T", start_date="2014-1-1", end_date="2014-3-3")
```

### ニコニコ動画で指定した動画の情報を取得する
動画idを指定してください。

```r
jaguchi("niconicoi", ids="nm25386207")
```

### ニコニコ動画で単語またはタグを指定して情報を取得する
スナップショット検索APIを利用して検索します。

ページネーションに未対応なので検索結果が大量になる場合エラーになることにご注意ください。

下記は「艦これ」というワードで検索結果数100を上限としてタグ検索をかける例です。
```r
jaguchi("niconicos", query="艦これ", size=100, type="tag")
```

