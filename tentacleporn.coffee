class SourceCodeParser
  constructor: (@transmogrifier, @text) -> #this assigns params to members
    #if someNode is 'var'
    #  transmogrifier.variableDeclaration someNode.varName
    #else if someNode is 'for' or 'while'
    #  transmogrifier.loopExpression someNode.stuff
    #else if someNode is 'if'
    #  transmogrifier.ifExpression someNode.stuff
    #else if someNode is 'function'
    #  transmogrifier.functionDeclaration someNode.parameters

class SourceTransmogrifier
  constructor: ->
    @value = ''
    @allTheInputParamsToTheFunction = {}
  
  transmogrify: (allTheTexts) ->
    new SourceCodeParser @, allTheTexts
    
# decides what the editor should display, but doesn't evaluate
class HoomanTransmogrifier extends SourceTransmogrifier
  # this is also singleton. heyooo
  singletonInstance = null
   
  @sharedInstance: ->
    if not singletonInstance
      singletonInstance = new @ # monica: this means this

    singletonInstance   # monica: this means "return singletonInstance"

  variableDeclaration: (theNameOfTheVariable) ->
    @value += "#{theNameOfTheVariable} = undefined"
  
  functionDeclaration: (parameters) ->
    for param in parameters
      @allTheInputParamsToTheFunction[param] = undefined
      @value += "#{param} = #{@allTheInputParamsToTheFunction[param]}\n"
      
  loopExpression: ->
# var i = 0;                    i = 0
# for (; i < 10; i++)           i = 0 | 1 | 2 | 3 | 4
# {
#   someThing = array[i];           someThing = 'a' | 'b' | 'c'
# }
# while (i < 5)           i = 0 | 1 | 2 | 3 | 4
# {
#   someThing = array[i];           someThing = 'a' | 'b' | 'c'
# }

  ifExpression: ->
# if ( a > 0 )   # display on the correct branch
#  a = 5                       a = 5
# or
# if ( a > 0 )
#  a = 5                       
# else
#  a = -5                      a = -5


  # this defines a function:
  makeSureAllTheVariablesAreStillAlive: ->
    for prettyVariableName in @allTheVariables
      'f'

  onEdit: ->
    

# actually evaluates all the things
class EvaluatingTransmogrifier extends SourceTransmogrifier
  # this is a singleton. heyooo
  singletonInstance = null
  
  @sharedInstance: ->
    if not singletonInstance
      singletonInstance = new @

    singletonInstance


# export ALL the things
window.HoomanTransmogrifier = HoomanTransmogrifier
window.EvaluatingTransmogrifier = EvaluatingTransmogrifier