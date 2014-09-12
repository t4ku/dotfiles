slate.config('windowHintsShowIcons',true);
slate.config('windowHintsIgnoreHiddenWindows',false);

slate.config('defaultToCurrentScreen',true);
slate.config('nudgePercentOf','screenSize');
slate.config('resizePercentOf','screenSize');

var pushOperations = {
    '2' : {
            'currentIndex' : 0,
            'operations'   : 
                [
                    slate.operation('push',{
                        'direction' : 'left',
                        'style'     : 'bar-resize:screenSizeX/2'
                    }),
                    slate.operation('push',{
                        'direction' : 'right',
                        'style'     : 'bar-resize:screenSizeX/2'
                    })
                ]
    }
};

var throwOperations = {
    currentIndex: 0
};

slate.bind('0:ctrl;alt',function(win){
    var throwOperation = slate.operation('throw',{
        'screen' : throwOperations.currentIndex
    });
    // index
    throwOperations.currentIndex = throwOperations.currentIndex + 1 < slate.screenCount() ? throwOperations.currentIndex + 1 : 0;
    win.doOperation(throwOperation);
});

slate.bind('1:ctrl;alt',function(win){
    var fullScreenOperation = slate.operation('move',{
        'x'      : 'screenOriginX',
        'y'      : 'screenOriginY',
        'width'  : 'screenSizeX',
        'height' : 'screenSizeY'
    });
    win.doOperation(fullScreenOperation);
});

slate.bind('2:ctrl;alt',function(win){
    var config = pushOperations['2'];
    var operation = config.operations[config.currentIndex];
    config.currentIndex = (config.currentIndex + 1 < config.operations.length) ? config.currentIndex + 1 : 0;
    win.doOperation(operation);
});
