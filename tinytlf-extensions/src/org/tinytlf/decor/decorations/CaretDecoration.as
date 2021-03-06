/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.tinytlf.decor.decorations
{
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.utils.Timer;
    
    import org.tinytlf.decor.TextDecoration;
    
    public class CaretDecoration extends TextDecoration
    {
        public function CaretDecoration(styleObject:Object = null)
        {
            super(styleObject);
        }
        
        private var timer:Timer;
        private var g:Graphics;
        private var rect:Rectangle;
        
        override public function setup(layer:int = 0, ...args):Vector.<Rectangle>
        {
            if(!timer)
                timer = new Timer(400);
            return super.setup.apply(null, [layer].concat(args));
        }
        
        override public function draw(bounds:Vector.<Rectangle>):void
        {
            super.draw(bounds);
            
            if(!bounds.length)
                return;
            
            rect = bounds[0];
            
            g = Shape(rectToLayer(rect).addChild(new Shape())).graphics;
            
            if(!timer.hasEventListener(TimerEvent.TIMER))
                timer.addEventListener(TimerEvent.TIMER, toggle);
			
            if(!timer.running)
            {
                toggle(null);
                timer.start();
            }
        }
        
        override public function destroy():void
        {
            super.destroy();
            
            if(timer)
            {
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, toggle);
            }
            timer = null;
            showing = false;
            if(g)
            {
                g.clear();
            }
            g = null;
            rect = null;
        }
        
        private var showing:Boolean = false;
        
        private function toggle(event:TimerEvent):void
        {
            if(!g)
                return;
            
            g.clear();
            
            showing = !showing;
            
            if(!showing)
                return;
            
            var right:int = int(Boolean(getStyle('position') == 'right'));
            
            g.lineStyle(getStyle('caretWeight') || 2, getStyle('caretColor'));
            g.moveTo(rect.x + right * rect.width, rect.y);
            g.lineTo(rect.x + right * rect.width, rect.y + rect.height);
        }
    }
}