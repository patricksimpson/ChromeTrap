ChromeTrapTimeout = null
ChromeTrapLameWindowClose = ->
  window.close()
ChromeTrapClearData = ->
  $("#question").val("")
  $("#solution").val("")
  $("#solved").val("")
  $("#unsolved").prop "checked",false
  storage.remove "steelTrapQuestion"
  storage.remove "steelTrapSolution"
  storage.remove "steelTrapSolved"

storage = chrome.storage.sync
$("#setTokenButton").bind "click", ->
  true 

$("#deleteToken").bind "click", ->
  deleteToken()
  false

$("#tokenNotSet").submit (event) ->
  saveToken()
  event.preventDefault()

$("#tokenSet").submit (event) ->
  theData = 
    token: $("#token").val()
    reference_url: $("#reference_url").val()
    question: $("#question").val()
    solution: $("#solution").val()
    solved: $("#solved").val()

  $form = $(this)
  serializedData = $form.serialize()
  $.post('http://steeltrap.co/api/v1/entries', serializedData, (data) ->
    if(data && data.error)
      $("#error").css("display", "block").text(data.error)
      false
    else
      $("#tokenSet").css("display", "none")
      $("#success").css("display", "block")
      $("#messageBox").html('<a href="http://steeltrap.co/entries/'+data.id+'" target="_blank">View</a> it or <a href="http://steeltrap.co/entries/'+data.id+'/edit" target="_blank">edit</a> on steeltrap.co</a>.')
      ChromeTrapClearData()
      false
    )
  false

$(".ChromeTrap-closeMe").bind "click", ->
  window.close()
  false
  
$(".ChromeTrap-clearMe").bind "click", ->
  ChromeTrapClearData()

$("#question").bind "change keyup", ->
  val = $("#question").val()
  storage.set steelTrapQuestion: val
  
$("#solution").bind "change keyup", ->
  val = $("#solution").val()
  storage.set steelTrapSolution: val

$("#solution").bind "keyup", ->
  if($(this).val() != "")
    $("#unsolved").prop "checked",true
    $("#solved").val("true")
    storage.set steelTrapSolved: "true"
  else
    $("#unsolved").prop "checked",false
    $("#solved").val("")
    storage.set steelTrapSolved: "false"
    
$("#unsolved").bind "change", ->
  if($(this).is(':checked'))
    $("#solved").val("true")
    storage.set steelTrapSolved: "true"
  else
    $("#solved").val("")
    storage.set steelTrapSolved: "false"
    
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
    storage.get "steelTrapQuestion", (data) ->
      $("#question").val(data.steelTrapQuestion)
    storage.get "steelTrapSolution", (data) ->
      $("#solution").val(data.steelTrapSolution)
    storage.get "steelTrapSolved", (data) ->
      if(data.steelTrapSolved == "true")
        $("#unsolved").prop "checked",true
      $("#solved").val(data.steelTrapSolved)  

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
