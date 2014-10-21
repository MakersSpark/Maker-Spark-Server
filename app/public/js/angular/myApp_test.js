myJSON = {"gitData":[{"format":"BOLD","text":"benjamintillett's GitHub Stats:"},{"format":"TEXT","text":"Score today: 0"},{"format":"TEXT","text":"Current streak: 0"},{"format":"TEXT","text":"Longest streak: 16"},{"format":"TEXT","text":"High score: 24 on 2014-08-29"}],"tube":[],"calendar":[{"format":"TEXT","text":"17:15 Demo: life at 1000WPM with Ethel"},{"format":"TEXT","text":"11:30 Spark Printer team meeting"},{"format":"TEXT","text":"10:00 Learning FORTRAN with Enrique"}],"forecast":"Light rain starting in 9 min., stopping 35 min. later.","people":[{"email":"ben@dog.com","name":"Ethel","age":22},{"name":"vincent","age":5}]}



describe("My First Test", function(){

    it("should be true", function(){
        expect(true).toBe(true);
    });
});


describe("myApp module", function () {
    beforeEach(module("myApp"));

    describe("MyCtrl", function () {
        var scope,
        controller;

        beforeEach(inject(function ($rootScope, $controller) {
            scope = $rootScope.$new();
            controller = $controller;
        }));

        it("on loading has show set to true", function () {
            controller("MyCtrl", {$scope: scope});
            expect(scope.gitState.show).toBe(true);
        });

        it('myJson["gitData"][0]["format"] = BOLD', function (){
        	expect(myJSON["gitData"][0]["format"]).toEqual("BOLD");
        });
    });

    describe("GitController", function () {
	    	var scope,
 			controller;

	    beforeEach(inject(function ($rootScope, $controller) {
	        scope = $rootScope.$new();
	        controller = $controller;
	    }));

	    it("can load the github data",function (){
	    	controller("GitController", {$scope: scope});
	    	spyOn(controller, "gitItems").and.returnValue("you for coffee");
	    	scope.loadGitData()
	    	expect(scope.gitItems).toEqual(myJSON["gitData"])
	    });
	 });
});


