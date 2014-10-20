app = angular.module("myApp",[])

app.controller "MyCtrl", ($scope, $http)->

	$scope.loadData = ->
		$http.get('http://localhost:9292/angular/jsons').success (data)->
			$scope.items =  data.people

	$scope.loadGitData = ->
		$http.get("https://api.github.com/users/benjamintillett?access_token=38bff0b3c9fb460aa58a4a5ea270e3b7af8c0cde").success (gitData)->
			$scope.gitItems = [gitData]
		
	$scope.loadForecast = ->
		$http.get('http://localhost:9292/angular/jsons').success (data)->
			$scope.forecasts =  [data.forecast]



	return