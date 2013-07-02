
CRITICAL = 1000000
HIGH     = 10000
NORMAL   = 100
LOW      = 10
INFO     = 1

# all creatures are defined and live in a reality
class Reality
  constructor: (@basePulsesPerSecond) ->
    loglevel = INFO
    @species = {}
    @creatures = []
    @tickInterval = @basePulsesPerSecond*1000
  # is this right?
  perSecond: (number) ->
    @basePulsesPerSecond * number
  addCreature: (creature) ->
    @creatures.push creature
  run: () ->
    @startedAt = new Date()
    @_interval = setInterval @tick.bind(@), @tickInterval
    @tick()
  tick: () ->
    for c in @creatures
      console.log 'pulse', c.species, c.attributes.energy
      c.pulse()
    1

# simplifying my planet as reality (as in, behavioural reality is what we percieve of it)
planet = new Reality(1)



class Species

  @_all: {}

  @register: (name, reality) ->
    proto = () ->
      @species = name
      @reality = reality
      @attributes = {}
      @newEvents = []
      # @priorities = new PriorityList(@)
      for k,v of @baseAttributes
        @attributes[k] = v
      @

    # reality "knows" what it has
    reality.species[name] = proto
    
    # this is probably flawed or should be bound to the prototype
    proto::biologicalRoutines = {}
    proto::actions = {}
    proto::priorityMap = {}

    # simple inheritance! ?=D
    for k,v of Species.instance
      # console.log "defining i #{k}"
      proto::[k] = v
      # console.log v.toString()
  
    proto.defineAction = (label, fn) ->
      proto::actions[label] = fn

    proto.defineBiologicalRoutine = (label, fn) ->
      proto::biologicalRoutines[label] = fn

    proto.defineBaseAttributes = (attributes) ->
      proto::baseAttributes = attributes

    proto.definePriority = (label, fn) ->
      proto::priorityMap[label] = fn

    proto

  # has behaviours

  # has attributes

  # has priorities

  # has curiosities

  # has interactions

  # has intents

  # has biological routine

  # has possessions

  @instance:

    pulse: () ->
      # not an option
      @biologicalMaintenance()
      # happens passively
      @senseEnvironment()
      # encompass interactions
      @understandEvents()
      # in support of meaning of life
      @evaluatePriorities()
      # kinda like making a plan
      @addressPriorities()
      # meaning of life?
      @takeAction()

    biologicalMaintenance: () ->
      # this line will fuckup
      for name, routine of @biologicalRoutines
        @log INFO, "running #{name}"
        routine.call @
      1

    # not everything need a name, it just happen that a lot of things have one
    setName: (@name) ->

    setAttribute: (attr,value) ->
      @attributes[attr] = value

    evaluatePriorities: () ->
      evaluatePriorities

    log: (priority, message) ->
      if priority >= @reality.loglevel
        console.log message

    senseEnvironment: () ->
      1

    understandEvents: () ->
      2

    evaluatePriorities: () ->
      3

    addressPriorities: () ->
      4

    takeAction: () ->
      5



Dog = Species.register 'Dog', planet

Dog.defineBaseAttributes {
    energy: 50
    hungry: 50
    happiness: 50
    needToExercise: 10
    jawStrength: 10
    empathyToPeople: 50
  }

Dog.defineBiologicalRoutine 'methabolism', () ->
  @attributes.energy -= @reality.perSecond(0.1)

Dog.defineAction 'ask for food', () ->
  @log CRITICAL, 'gimme food, yo!'

Dog.definePriority 'hunger', () ->
  (100 - @attributes.energy)*10

toto = new Dog()

planet.addCreature toto

planet.run()

