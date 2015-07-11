
package ru.ogres.zsm;


class FSMState {

    public var Parent:FSM = null;
    public function enter(context:Dynamic):String { return ""; }
    public function exit(context:Dynamic):String { return ""; }
    public function update():Void {  }
    public function event(eventName:String, context:Dynamic):String { return ""; }
}

class FSM extends ZObject  {

    var states:Map<String, FSMState> = new Map<String, FSMState>();
    var _currentState:FSMState = null;
    public var currentState(get, null):FSMState;
    function get_currentState():FSMState { return _currentState; }

    var _currentStateName:String = null;
    public var currentStateName(get, null):String;
    function get_currentStateName():String { return _currentStateName; }


    public function changeState(newState:String, ?context:Dynamic):Void {
        exit(newState, context);
    }

    public function start(newState:String, ?context:Dynamic):Void {
        if (currentState == null)
            enter(newState, context);
    }

    public function event(newState:String, ?context:Dynamic):Void {
        if (currentState != null){
            var _newState:String = currentState.event(newState, context);
            if (_newState != "")
                exit(newState, context);
        }
    }


    function exit(newState:String, context:Dynamic):Void {
        if (currentState!=null){
            this.eventManager.invoke("fsm:exit", currentStateName);
            var _newState:String = currentState.exit(context);
            _currentState = null;
            if (_newState != "")
                enter(_newState, context);
            else 
                enter(newState, context);
        }
    }

    function enter(newState:String, context:Dynamic):Void {
            _currentStateName = newState;
            _currentState = states.get(newState);
            this.eventManager.invoke("fsm.enter", currentStateName);
            var _newState:String = currentState.enter(context);
            if (_newState != "")
                exit(_newState, context);
    }

    function update() {
        if (this.currentState != null)
            this.currentState.update();
    }

    public function addState(stateName:String, state:FSMState){
        states.set(stateName, state);
    }



}