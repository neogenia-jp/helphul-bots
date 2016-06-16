
cronJob = require('cron').CronJob
request = require('request')

module.exports = (robot) ->
  # 特定のチャンネルへ送信するメソッド(定期実行時に呼ばれる)
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # 株価を回答する
  robot.hear /\b(\d\d\d\d)\b/i, (res) ->
    url = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=" + res.match[1]

    request.get url, (error, response, body) ->
      if !error && response.statusCode == 200
        mr_company = body.match(/<th class="symbol"><h1>([^\<]+)<\/h1><\/th>/)||[]
        mr_price = body.match(/<td class="stoksPrice">([\d,\.]+)<\/td>/)||[]
        if mr_price[1]
          res.send "[" + res.match[1] + "] " + mr_company[1] + " の株価は " + mr_price[1] + " 円です。"
      else
        console.log('error: '+ response.statusCode)
  
  send_namba_ramen = (rank) ->
    url = "http://tabelog.com/osaka/A2701/A270202/rstLst/MC/?SrtT=rt&Srt=D&sort_mode=1"
    request.get url, (error, response, body) ->
      if !error && response.statusCode == 200
        m = body.match(///<a[^\<]+data-ranking="#{rank}"[^\<]+href="([^"]+)"[^\<]+>([^<]+)<///) || []
        if m
           link_url= m[1]
           ramen_shop_name = m[2]
           send "#random", "そろそろお腹が減りました。 たまにはラーメン食べに行きましょう。\n今日のおすすめはなんばで第#{rank}位の #{ramen_shop_name} !\n#{link_url}"
      else
        console.log('error: '+ response.statusCode)

  # 月〜金のお昼を知らせる機能を追加
  new cronJob('0 30 12 * * 1-5', () ->
    send_namba_ramen(Math.ceil(Math.random() * 10))
  ).start()

  # 月〜金の定義を知らせる機能を追加
  new cronJob('0 30 18 * * 1-5', () ->
    send '#random', "そろそろお腹が減りました。 たまにはラーメン食べに行きましょう。"
  ).start()

