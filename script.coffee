storage = chrome.storage.sync
$("#setTokenButton").bind "click", ->
  saveToken()
  false

$("#deleteToken").bind "click", ->
  deleteToken()
  false

$("#tokenNotSet").submit (event) ->
  event.preventDefault()

getToken = ->
  console.log "getting token"
  storage.get "steelTrapAPIToken", (data) ->
    data.steelTrapAPIToken
    checkToken data.steelTrapAPIToken


checkToken = (token) ->
  console.log token
  if token and token isnt ""
    $("#tokenNotSet").css "display", "none"
    $("#tokenSet").css "display", "block"
    $("#tokenSetError").css "display", "none"
    $("#token").val token
    chrome.tabs.getSelected null, (tab) ->
      tablink = tab.url
      $("#cst__refurl").val tablink

  else
    $("#tokenNotSet").css "display", "block"
    $("#tokenSet").css "display", "none"
    $("#tokenSetError").css "display", "block"

saveToken = ->
  val = $("#newToken").val()
  storage.set steelTrapAPIToken: val
  getToken()
  false

deleteToken = ->
  console.log "deleting local storage!"
  storage.remove "steelTrapAPIToken"
  checkToken()

getToken()