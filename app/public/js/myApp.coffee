app = angular.module("myApp",[])

app.controller "MyCtrl", ($scope, $http)->

	$scope.loadData = ->
		$scope.items =  $scope.data.people

	$scope.loadGitData = ->
		$scope.gitItems = $scope.initGitData
		
	$scope.loadForecast = ->
			$scope.forecasts =  [$scope.data.forecast]

	$scope.init = ($scope,$http)->
 		$http.get("https://api.github.com/users/benjamintillett?access_token=38bff0b3c9fb460aa58a4a5ea270e3b7af8c0cde").success (data)->
 			$scope.initGitData = [data]

 		$http.get('http://localhost:9292/angular/jsons').success (data)->
 			$scope.data = data




 	$scope.init($scope,$http)
 	return



