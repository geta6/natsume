
# Natsume

* websocketを使用したすごくてかわいいwiki
  * 編集合戦の平和的終結を目指す女神
* 設計には体感応答性能と手軽さが重視されるべき?

## Route

### `/`

    ┌─────────────┐
    │           夏芽           │
    │  ┌─────────┐  │
    │  │textarea|         │  │
    │  │                  │  │
    │  │                  │  │
    │  │                  │  │
    │  └─────────┘  │
    │         [Create]         │
    └─────────────┘


### `/:repo`

    ┌─────────────────┐
    │   repotitle                      │
    │  ┌───────┐┌────┐  │
    │  │index         ││[search]│  │
    │  │textview      ││pagelist│  │
    │  │              ││        │  │
    │  │              ││        │  │
    │  └───────┘└────┘  │
    │                                  │
    └─────────────────┘

### `/:repo/:page`

    ┌─────────────────┐
    │   repotitle::pagetitle           │
    │  ┌───────┐┌────┐  │
    │  │textview      ││[search]│  │
    │  │              ││pagelist│  │
    │  │              ││        │  │
    │  │              ││        │  │
    │  └───────┘└────┘  │
    │                                  │
    └─────────────────┘


### 機能

* 完全同期なエディタ
  * 最後に実装する
* 同じページにいる人同士でチャット可能
* 自分の名前を宣言できる
  * 虚偽申告可能、localStorage使って保存する

### 議論

* BASIC、パスワードをrepoのパスワード、ユーザ名を自由にしてはどうか
  * geta6:hogehogeとやると、ページのパスワードがhogehogeならとおる
  * ユーザ名がgeta6として設定される
    * アリ


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


## WebSocket

    ┌[repo]────────────────────┐
    │                                              │
    │  ┌[page-A]─┐┌[page-B]─┐┌[page-C]─┐  │
    │  │          ││          ││          │  │
    │  │          ││          ││          │  │
    │  │          ││          ││          │  │
    │  │          ││          ││          │  │
    │  └─────┘└─────┘└─────┘  │
    │                                              │
    └───────────────────────┘

* `repo`を見ている人に対して
  * `repo`の変更は通知される
  * `page-A`・`page-B`・`page-C`の変更が通知される
* `page-A`を見ている人に対して
  * `repo`の変更は通知される
  * `page-A`の変更は`page-A`へ通知される
  * `page-B`の変更は通知されない
