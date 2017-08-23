// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs

//= require rails-jquery-tokeninput
//= require_tree .


$(document).ready(function(){
	$("#project_user_tokens").tokenInput("/users.json",
	{
		queryParam: 'q',
		minChars: 2,
		propertyToSearch: "username",
		hintText: "ユーザー名から検索する",
		noResultsText: "このユーザーは見つかりませんでした。",
		searchingText: "検索中...",
		theme: "facebook",
		preventDuplicates: true,
		prePopulate: $('#project_user_tokens').data('load'),
		resultsFormatter: function(item){ return "<li>" + item.username + " " + item.company + "</li>" },
	});
});