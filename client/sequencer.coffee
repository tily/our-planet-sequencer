worker = require('./worker')
_ = require('underscore')

module.exports = class Sequencer
  loopDuration: 4.0
  notes: [
    {name: 'tone440', type: 'tone', frequency: 440, duration: 0.1}
    {name: 'tone880', type: 'tone', frequency: 880, duration: 1.0}
    {name: 'kick', type: 'wave', file: 'kick.wav'} 
    {name: 'snare', type: 'wave', file: 'snare.wav'}
    {name: 'hihat-o', type: 'wave', file: 'hihat-open.wav'}
    {name: 'hihat-c', type: 'wave', file: 'hihat-close.wav'}
    {name: 'clap', type: 'wave', file: 'clap.wav'}
  ]
  timings: [
    {name: 'tone440', start: 0.1}
    {name: 'tone440', start: 1.0}
    {name: 'tone440', start: 2.0}
    {name: 'tone880', start: 3.0}
  ]

  constructor: ()->
    @audioContext = new AudioContext()

  loadWaves: (options)->

  playNote: (name)->
    # TODO: play real time
    @recordNote(name) if @recording

  clearNote: (name)->
    for timing, i in @timings
      delete timing[i] if timing.name == name

  recordNote: (name)->
    @timing.push(name: name, start: @timeInLoop())

  start: ()->
    @startTime = @audioContext.currentTime
    worker.onmessage = @onTick
    worker.postMessage interval: 25.0
    worker.postMessage 'start'

  onTick: (e)=>
    if e.data == 'tick'
      @schedule()
    else
      console.log 'message=' + e.data

  schedule: ()->
    for timing in @timings
      if !timing.seen && timing.start < @timeInLoop()
        @scheduleNote(timing)
        timing.seen = true
        if(_.every @timings, (_timing)-> _timing.seen)
          console.log 'resetting'

  scheduleNote: (timing)=>
    note = _.find @notes, (note)-> note.name == timing.name
    switch note.type
      when 'tone' then @scheduleTone(timing, note)
      when 'wave' then @scheduleWave(timing, note)

  scheduleWave: (timing, note)->
    console.log 'scheduleWave'

  scheduleTone: (timing, note)->
    console.log 'scheduleTone'
    oscillator = @audioContext.createOscillator()
    oscillator.connect @audioContext.destination
    oscillator.frequency.value = note.frequency
    oscillator.start timing.start
    oscillator.stop timing.start + note.duration

  stop: ()->
    worker.postMessage 'stop'

  ellapse: ()->
    @audioContext.currentTime - @startTime

  timeInLoop: ()->
    @ellapse() % @loopDuration
