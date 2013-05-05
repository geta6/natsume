
# Natsume

## Response

### Status Code

Code | Status
-----|--------
200  | おk
201  | 作成できたよー＾O＾ノ
400  | 不正なパラメータが送信された、クエリに欠損がある
403  | パラメータはおkだけど、その値では受け付けられない


## Tips

* HEAD
  * レスポンスヘッダーだけを返すべきメソッド
  * `$.ajax type: 'HEAD'`
