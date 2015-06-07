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

Sequencer = require('./client/sequencer')

window.onerror = (e, u, l)-> alert 'Error: ' + e + ' Script: ' + u + ' Line: ' + l

sequencer = new Sequencer()
sequencer.start()

App = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ()->
    playing: true

  handleClickToggle: ()->
    console.log 'hello'
    if @state.playing
      sequencer.stop()
    else
      sequencer.start()
    @setState playing: !@state.playing, ()->

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
