require('./client.css')
require('blueimp-canvas-to-blob')
$ = require('jquery')
React = require('react/addons')
Navbar = require('react-bootstrap').Navbar
Nav = require('react-bootstrap').Nav
NavItem = require('react-bootstrap').NavItem
Button = require('react-bootstrap').Button
Input = require('react-bootstrap').Input
Glyphicon = require('react-bootstrap').Glyphicon
window.html2canvas = html2canvas = require('html2canvas')
classnames = require('classnames')
worker = require('./client/worker')

window.onerror = (e, u, l)-> alert 'Error: ' + e + ' Script: ' + u + ' Line: ' + l

@audioContext = new AudioContext()
currentTime = @audioContext.currentTime
osc = @audioContext.createOscillator()
osc.connect @audioContext.destination
osc.frequency.value = 400
osc.start currentTime
osc.stop currentTime + 0.1

osc = @audioContext.createOscillator()
osc.connect @audioContext.destination
osc.frequency.value = 400
osc.start currentTime + 1.0
osc.stop currentTime + 1.0 + 0.1

osc = @audioContext.createOscillator()
osc.connect @audioContext.destination
osc.frequency.value = 400
osc.start currentTime + 2.0
osc.stop currentTime + 2.0 + 0.1

osc = @audioContext.createOscillator()
osc.connect @audioContext.destination
osc.frequency.value = 800
osc.start currentTime + 3.0
osc.stop currentTime + 3.0 + 1.0

{timbre: '', start: '', duration: ''}

worker.onmessage = (e)->
  if e.data == 'tick'
  else
    console.log 'message=' + e.data

worker.postMessage interval: 25.0
worker.postMessage 'start'

App = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ()->
    playing: true

  handleClickToggle: ()->
    console.log 'hello'
    @setState playing: !@state.playing

  render: ->
    <div>
      <Navbar fixedBottom>
        <div onClick={@handleClickToggle} style={display:'flex',justifyContent:'center',alignItems:'center',fontSize:'5vh'}>
          {
            if @state.playing
              <Glyphicon glyph='pause' />
            else
              <Glyphicon glyph='play' />
          }
          <Glyphicon glyph='record' />
        </div>
      </Navbar>
      <div className='container'>
        <div className='row title-row'>
          <div className='col-sm-12'>
            <h1 className='text-center'>
              <span className='title-wrapper'>
                <span className='title'>
                  わ が 星
                </span>
              </span>
            </h1>
          </div>
        </div>
        <div className='row circle-row'>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
          <div className='col-xs-4 col-sm-4 circle-col'>
            <div className='circle'>
            </div>
          </div>
        </div>
      </div>
    </div>

$(document).ready ()->
  app = React.createFactory(App)
  React.render app(), document.getElementById('client')
