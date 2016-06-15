# helphul-bot

helphul-bot は便利な bot をまとめたリポジトリです。
現在、以下の bot が含まれています。

- itoh-bot

itoh-bot は伊藤さんに敬意を表して制作された Slack bot です。
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
% sudo docker build -t helpful-bot .
% sudo docker run -ti -e HUBOT_SLACK_TOKEN=<slack-api-token> -v `pwd`/itoh-bot:/opt/hubot-root helpful-bot
```

