app = angular.module("myApp",[])

app.controller "MyCtrl", ($scope, $http)->

	$scope.loadData = ->
		$scope.items =  $scope.data.people

	$scope.addData = ->
		$scope.users =  $scope.items

	$scope.loadGitData = ->
		$scope.gitItems = $scope.data.gitData

	$scope.addGitData = ->
		$scope.gits = $scope.gitItems		

		
	$scope.loadForecast = ->
			$scope.forecasts =  [$scope.data.forecast]

	$scope.loadCalendar = ->
			$scope.events =  $scope.data.calendar


	$scope.init = ($scope,$http)->
 		$http.get('http://localhost:9292/angular/jsons').success (data)->
 			$scope.data = data

 	$scope.init($scope,$http)
 	return



