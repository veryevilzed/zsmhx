
package ru.ogres.zsm;


class ZEventManager {

    var events:Map<String, Array<String -> Dynamic -> Void >> = null;

    public function bind(eventName:String, target:String -> Dynamic -> Void):Void {
        if (!this.events.exists(eventName))
            this.events.set(eventName, new Array<String -> Dynamic -> Void>()); 
        this.events.get(eventName).push(target);
    }

    public function unbind(target:String -> Dynamic -> Void):Void {
        for(k in events.keys()){
            for(t in events.get(k)){  
                if (t == target)
                    events.remove(k);
            }
        }
    }

    public function invoke(eventName:String, context:Dynamic):Void {
        if (!this.events.exists(eventName))
            return;
        for(target in events[eventName])
            target(eventName, context);
    }

    public function new() {
        this.events = new Map<String, Array<String -> Dynamic -> Void>>();
    }


}