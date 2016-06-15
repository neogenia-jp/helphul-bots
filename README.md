# itoh-hubot

itoh-hubot は伊藤さんに敬意を表して制作された Slack bot です。
Hubot をベースに実装されています。


## ローカル実行

開発時など、ローカルで実行するには以下のコマンドで実行できます。

```
% bin/hubot
```


## 永続化

Redisによる永続化には対応していません。


## アダプタ

Slackアダプタを使用する場合は以下のようにします。

```
% HUBOT_SLACK_TOKEN=<slack-api-token> bin/hubot -a slack
```

## Docker

```
% cd {repo-root}
% sudo docker build -t helphul-bot .
% docker run -e HUBOT_SLACK_TOKEN=<slack-api-token> -v `pwd`/itoh-bot:/opts/hubot-root helpful-bot
```

