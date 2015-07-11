
package ru.ogres.zsm;

class ZData extends ZObject {

    
    var data:Map<String, Dynamic> = new Map<String, Dynamic>();


    public function set(key:String, value:Dynamic):Void {
        data.set(key, value);
        eventManager.invoke('change:$key', value);
        eventManager.invoke("change:*", value);
    }

    public function get(key:String, ?def:Dynamic):Dynamic {
        if (data.exists(key))
            return data.get(key);
        else
            return def;
    }



}