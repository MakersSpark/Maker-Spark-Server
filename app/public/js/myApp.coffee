app = angular.module("myApp",[])

app.controller "MyCtrl", ($scope, $http)->

	$scope.loadData = ->
		$scope.items =  $scope.data.people

	$scope.addGitData = ->
		$scope.messages.splice(0,0,$scope.gitItems )

	$scope.loadGitData = ->
		$scope.gitItems = $scope.data.gitData
		
	$scope.loadForecast = ->
			$scope.forecasts =  [$scope.data.forecast]

	$scope.loadCalendar = ->
			$scope.events =  $scope.data.calendar

	$scope.addCalendarData = ->
		$scope.messages.splice(0,0,$scope.events )


	$scope.init = ($scope,$http)->
 		$http.get('http://localhost:9292/angular/jsons').success (data)->
 			$scope.data = data
 			$scope.messages = []
 	$scope.init($scope,$http)
 	return



