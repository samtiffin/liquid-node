Liquid = require "../../liquid"
util = require 'util'

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
  Syntax      = ///^#{Liquid.QuotedFragment.source}///g
  NamedSyntax = ///^(#{Liquid.QuotedFragment.source})\s*\:\s*(.*)///g
  SyntaxHelp  = "Syntax Error in 'cycle' - Valid syntax: cycle 'a', 'b'"

  constructor: (tagName, markup, token) ->
    match = markup.match(Syntax)
    namedMatch = markup.match(NamedSyntax)

    if namedMatch
      @name = match[0]
      @variables = match.slice(2).filter((v)->v)
    else if match
      @variables = match.filter((v)->v)
      @name = match.toString()
    else
      throw new Liquid.SyntaxError(SyntaxHelp)

  render: (context) ->
    context.registers.cycle or= {}

    context.stack =>
      key = context.get(@name)
      iteration = context.registers['cycle'][key] or 0
      result = context.get(@variables[iteration])
      iteration += 1
      iteration = 0 if iteration >= @variables.length
      context.registers['cycle'][key] = iteration
      result

Liquid.Template.registerTag 'cycle', Cycle