ChromeTrapOptions = null
storage = chrome.storage.sync

ChromeTrapGetOptions = ->
  storage.get "chromeTrapOptions", (data) ->
    if(data.chromeTrapOptions)
      ChromeTrapOptions = data.chromeTrapOptions
    else
      ChromeTrapOptions =
        "CT-opt-public": true
        "CT-opt-autosolved": true
        "CT-opt-show-urlref": true
        "CT-opt-show-public": true
        "CT-opt-show-solved": true
        "CT-opt-show-solution": true
        "CT-opt-show-deck-input": true
        "CT-opt-show-tag-input": true
      storage.set chromeTrapOptions: ChromeTrapOptions
    $("#CT-opt-show-urlref").prop("checked", ChromeTrapOptions['CT-opt-show-urlref'])
    $("#CT-opt-public").prop("checked", ChromeTrapOptions['CT-opt-public'])
    $("#CT-opt-autosolved").prop("checked", ChromeTrapOptions['CT-opt-autosolved'])
    $("#CT-opt-show-public").prop("checked", ChromeTrapOptions['CT-opt-show-public'])
    $("#CT-opt-show-solved").prop("checked", ChromeTrapOptions['CT-opt-show-solved'])
    $("#CT-opt-show-solution").prop("checked", ChromeTrapOptions['CT-opt-show-solution'])
    $("#CT-opt-show-deck-input").prop("checked", ChromeTrapOptions['CT-opt-show-deck-input'])
    $("#CT-opt-show-tag-input").prop("checked", ChromeTrapOptions['CT-opt-show-tag-input'])

ChromeTrapGetOptions()


ChromeTrapOptionsBindings = ->
  $("#CT-opt-public").bind("change", ->
    ChromeTrapOptions['CT-opt-public'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-autosolved").bind("change", ->
    ChromeTrapOptions['CT-opt-autosolved'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-public").bind("change", ->
    ChromeTrapOptions['CT-opt-show-public'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-urlref").bind("change", ->
    ChromeTrapOptions['CT-opt-show-urlref'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-solved").bind("change", ->
    ChromeTrapOptions['CT-opt-show-solved'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-solution").bind("change", ->
    ChromeTrapOptions['CT-opt-show-solution'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-deck-input").bind("change", ->
    ChromeTrapOptions['CT-opt-show-deck-input'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#CT-opt-show-tag-input").bind("change", ->
    ChromeTrapOptions['CT-opt-show-tag-input'] = $(this).prop "checked"
    storage.set chromeTrapOptions: ChromeTrapOptions
    )
  $("#setNewTokenButton").bind "click", ->
    saveToken("#CT-newToken")
  storage.get "steelTrapAPIToken", (data) ->
    $("#CT-newToken").val(data.steelTrapAPIToken)
    
ChromeTrapOptionsBindings()