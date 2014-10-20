// Generated by CoffeeScript 1.8.0
(function() {
  var app;

  app = angular.module("myApp", []);

  app.controller("MyCtrl", function($scope, $http) {
    $scope.loadData = function() {
      return $scope.items = $scope.data.people;
    };
    $scope.addData = function() {
      return $scope.users = $scope.items;
    };
    $scope.loadGitData = function() {
      return $scope.gitItems = $scope.data.gitData;
    };
    $scope.addGitData = function() {
      return $scope.gits = $scope.gitItems;
    };
    $scope.loadForecast = function() {
      return $scope.forecasts = [$scope.data.forecast];
    };
    $scope.loadCalendar = function() {
      return $scope.events = $scope.data.calendar;
    };
    $scope.init = function($scope, $http) {
      return $http.get('http://localhost:9292/angular/jsons').success(function(data) {
        return $scope.data = data;
      });
    };
    $scope.init($scope, $http);
  });

}).call(this);
