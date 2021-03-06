package org.tinytlf.interaction.gestures.mouse
{
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;
    
    import org.tinytlf.interaction.gestures.Gesture;

    [Event("mouseDown")]
    [Event("mouseUp")]
    [Event("mouseMove")]
    [Event("click")]
    [Event("doubleClick")]

    public class MouseClickGesture extends Gesture
    {
        public function MouseClickGesture(target:IEventDispatcher = null)
        {
            super(target);

            hsm.appendChild(<down/>);
            hsm.appendChild(<drag/>);
            hsm.appendChild(<up/>);
            hsm.appendChild(<click/>);
            hsm.appendChild(<doubleClick/>);
        }

        public function click(event:MouseEvent):Boolean
        {
            return event.type == MouseEvent.CLICK;
        }

        public function doubleClick(event:MouseEvent):Boolean
        {
            return event.type == MouseEvent.DOUBLE_CLICK;
        }

        public function down(event:MouseEvent):Boolean
        {
            return event.type == MouseEvent.MOUSE_DOWN;
        }

        public function up(event:MouseEvent):Boolean
        {
            return event.type == MouseEvent.MOUSE_UP;
        }

        public function drag(event:MouseEvent):Boolean
        {
            return event.type == MouseEvent.MOUSE_MOVE && event.buttonDown;
        }
    }
}