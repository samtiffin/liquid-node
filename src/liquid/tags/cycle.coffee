Liquid = require "../../liquid"

# Cycle is usually used within a loop to alternate between values, like colors or DOM classes.
#
#   {% for item in items %}
#     <div class="{% cycle 'red', 'green', 'blue' %}"> {{ item }} </div>
#   {% end %}
#
#    <div class="red"> Item one </div>
#    <div class="green"> Item two </div>
#    <div class="blue"> Item three </div>
#    <div class="red"> Item four </div>
#    <div class="green"> Item five</div>
#
module.exports = class Cycle extends Liquid.Block
  Syntax = ///^#{Liquid.QuotedFragment.source}+///
  NamedSyntax = ///^(#{Liquid.QuotedFragment.source})\s*\:\s*(.*)///
  SyntaxHelp = "Syntax Error in 'cycle' - Valid syntax: cycle 'a', 'b'"

  constructor: (tagName, markup, token) ->
    if match = Syntax.exec(markup)
      console.log match
    else if match = NamedSyntax.exec(markup)
      console.log match
    else
      throw new Liquid.SyntaxError(SyntaxHelp)

  render: (context) ->

Liquid.Template.registerTag 'cycle', Cycle