
cronJob = require('cron').CronJob

module.exports = (robot) ->
  
  # 特定のチャンネルへ送信するメソッド(定期実行時に呼ばれる)
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # 株価を回答する
  robot.hear /\b(\d\d\d\d)\b/i, (res) ->
    request = require('request')
    url = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=" + res.match[1]

    request.get url, (error, response, body) ->
      if !error && response.statusCode == 200
        mr_company = body.match(/<th class="symbol"><h1>([^\<]+)<\/h1><\/th>/)||[]
        mr_price = body.match(/<td class="stoksPrice">([\d,\.]+)<\/td>/)||[]
        if mr_price[1]
          res.send "[" + res.match[1] + "] " + mr_company[1] + " の株価は " + mr_price[1] + " 円です。"
      else
        console.log('error: '+ response.statusCode)
  
  # 月〜金のお昼を知らせる機能を追加
  new cronJob('0 30 12 * * 1-5', () ->
    send '#random', "ランチはどうしますか？ ラーメンでも食べに行きましょうよ。"
  ).start()

  # 月〜金の定義を知らせる機能を追加
  new cronJob('0 30 18 * * 1-5', () ->
    send '#random', "そろそろお腹が減りました。 たまにはラーメン食べに行きましょう。"
  ).start()

