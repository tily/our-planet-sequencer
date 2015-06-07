InlineWorker = require('inline-worker')

module.exports = new InlineWorker ()->
  # based on https://github.com/cwilso/metronome/blob/master/js/metronomeworker.js
  timerID = null
  interval = 100
  self.onmessage = (e)->
    if e.data == 'start'
      console.log 'starting'
      timerId = setInterval (-> postMessage('tick')), interval
    else if e.data.interval
      console.log 'setting interval'
      interval = e.data.interval
      console.log 'interval=' + interval
      if timerID
        clearInterval(timerID)
        #timerID = setInterval (-> postMessage('tick')), interval
    else if e.data == 'stop'
      console.log "stopping"
      clearInterval timerID
      timerID = null
  return # don't output javascript return
