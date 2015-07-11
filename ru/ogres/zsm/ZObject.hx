
package ru.ogres.zsm;


class ZObject {
    var _eventManager:ZEventManager = new ZEventManager();
    public var eventManager(get, null):ZEventManager;
    function get_eventManager():ZEventManager {
        return _eventManager;
    }

}