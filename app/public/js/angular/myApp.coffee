app = angular.module("myApp",[])

app.controller "MyCtrl", ($scope, $http)->

	$scope.loadData = ->
		$scope.items =  $scope.data.people

	$scope.addGitData = ->
		$scope.messages.splice(0,0,$scope.gitItems )

	$scope.loadGitData = ->
		$scope.gitItems = $scope.data.gitData

	$scope.toggleGit = ->
		$scope.gitState.show = !$scope.gitState.show

		
	$scope.loadForecast = ->
			$scope.forecasts =  [$scope.data.forecast]

	$scope.loadCalendar = ->
			$scope.events =  $scope.data.calendar

	$scope.addCalendarData = ->
		$scope.messages.splice(0,0,$scope.events )

	$scope.loadTube = ->
			$scope.tubes =  $scope.data.tube

	$scope.addTube = ->
		$scope.messages.splice(0,0,$scope.tubes )



	$scope.init = ($scope,$http)->
 		$scope.messages = []
 		$scope.gitState = { show: true}
 		$http.get('http://localhost:9292/angular/jsons').success (data)->
 			$scope.data = data

 	$scope.init($scope,$http)
 	return

# app.controller "GitController", ($scope,$http)->

# 	$scope.loadGitData = ->
# 		$scope.gitItems = "aaaaa"

# 	$scope.init = ($scope,$http)->
#  		$scope.messages = []
#  		$scope.gitState = { show: true}
#  		$http.get('http://localhost:9292/angular/jsons').success (data)->
#  			$scope.data = data

#  	$scope.init($scope,$http)
#  	return




