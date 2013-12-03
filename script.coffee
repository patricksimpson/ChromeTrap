storage = chrome.storage.sync
$("#setTokenButton").bind "click", ->
  saveToken()
  false

$("#deleteToken").bind "click", ->
  deleteToken()
  false

$("#tokenNotSet").submit (event) ->
  event.preventDefault()
  
$("#solution").bind "keyup", ->
  if($(this).val() != "")
    $("#unsolved").prop "checked",true
    $("#solved").val("true")
  else
    $("#unsolved").prop "checked",false
    $("#solved").val("")
    
$("#unsolved").bind "change", ->
  if($(this).is(':checked'))
    $("#solved").val("true")
  else
    $("#solved").val("")
    
getToken = ->
  storage.get "steelTrapAPIToken", (data) ->
    data.steelTrapAPIToken
    checkToken data.steelTrapAPIToken


checkToken = (token) ->
  if token and token isnt ""
    $("#tokenNotSet").css "display", "none"
    $("#tokenSet").css "display", "block"
    $("#tokenSetError").css "display", "none"
    $("#token").val token
    chrome.tabs.getSelected null, (tab) ->
      tablink = tab.url
      $("#cst__refurl").val tablink
      $("#url_capture").text tablink

  else
    $("#tokenNotSet").css "display", "block"
    $("#tokenSet").css "display", "none"
    $("#tokenSetError").css "display", "block"
    $("#tokenSetError").text "Api Key not set, please enter a valid Api Key."

saveToken = ->
  val = $("#newToken").val()
  storage.set steelTrapAPIToken: val
  getToken()
  false

deleteToken = ->
  storage.remove "steelTrapAPIToken"
  checkToken()

getToken()