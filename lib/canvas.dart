part of game;

class Canvas {

	CanvasElement canvas;
	int width;
	int height;

	Canvas () {

		canvas = querySelector('#canvas');
		gl = canvas.getContext('webgl');
		if(gl==null) gl = canvas.getContext('experimental-webgl');
		if(gl==null) window.alert('WebGL failed to create a context');
		if(gl!=null) print('WebGL context created!');

		width = canvas.width;
		height = canvas.height;
		gl.viewport(0, 0, width, height);
	}

	runFunc (var func) => window.requestAnimationFrame(func);

}