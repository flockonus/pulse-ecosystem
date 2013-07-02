
###
  Activity performed by some species in order to address one or more priorities
  May also be understood as a solution to a problem

###
class Task
  constructor: (@label, @performer) ->
    # Number, should always be from 0 to 1, representing an estimated percentage 
    @completed = 0

    unless @label && @performer
      throw "missing label and or performer"
    unless @canBePerformed
      throw "#{performer.species} cant perform this"

  # this task is abstract, noone can perform =)
  speciesAllowed: () ->
    []

  # may also require skill, item or someone or ..
  canBePerformed: () ->
    @speciesAllowed.indexOf(@performer.species) > -1

  ###
    should add to @completed,
      fail,
      or something like that
    
    return: Number(0..1)
  ###
  perform: () ->
    @completed

  ###
    #TODO needs more thinking on this

    if completed == 100 it return true, false otehrwise
  ###
  isDone: () ->
    @completed == 100


###
  Performer: Species

  Message: String
    raw dump to console
###
class TaskBitchToConsole extends Task
  constructor: (@performer, @message) ->
    super 'BitchToConsole', @performer

  perform: () ->
    console.log "#{@performer.name}(#{@performer.species}): #{@message}"
    done()

module.Task = Task
module.TaskBitchToConsole = TaskBitchToConsole

