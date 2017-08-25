# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#project_user_tokens').tokenInput '/users.json'
  theme: 'facebook'
  queryParam: 'q',
  minChars: 2,
  propertyToSearch: "username",
  hintText: "ユーザー名から検索する",
  noResultsText: "このユーザーは見つかりませんでした。",
  searchingText: "検索中...",
  preventDuplicates: true,
  prePopulate: $('#project_user_tokens').data('load')

	