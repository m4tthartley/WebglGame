library game;

import 'dart:html';
import 'dart:math' as Math;
import 'dart:typed_data';
import 'dart:web_gl' as GL;
import 'package:vector_math/vector_math.dart';

part 'lib/canvas.dart';
part 'lib/shader.dart';
part 'lib/buffer.dart';
part 'lib/texture.dart';

part 'src/buffers.dart';
part 'src/level.dart';

GL.RenderingContext gl;
Canvas canvas;
Shader shader;

var vertexPositionAttribute;
var textureCoordAttribute;
var modelViewMatrixUniform;
var cameraMatrixUniform;

Texture1 stone1;
Texture1 stone2;
Texture1 stoneSlab;
var stoneCracked;
Texture1 playerTexture;

double rotation = 0.0;
double animationFrame = 0.0;
double animationFrameWalk = 0.0;
List<bool> keysDown = new List<bool>(256);
List<bool> keysPressed = new List<bool>(256);
int LEFT = 37;
int RIGHT = 39;
int UP = KeyCode.UP;
int DOWN = KeyCode.DOWN;
double cameraX = 0.0;
double cameraZ = 0.0;
var rand = new Math.Random();

double lastSecond = 0.0;
double lastTick = 0.0;
double msPerTick = 1000.0/60.0;
double unprocessed = 0.0;
int frames = 0;
int ticks = 0;

void run (double time) {

	unprocessed += (time - lastTick) / msPerTick;
	lastTick = time;
	while(unprocessed >= 1.0){
		tick();
		ticks++;
		unprocessed--;
	}

	if(time - lastSecond > 1000.0) {
		lastSecond = time;
		print('frames ' + frames.toString() + ', ticks ' + ticks.toString());
		frames = 0;
		ticks = 0;
	}

	render();
	frames++;

	canvas.runFunc(run);
}

void render () {

	gl.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
	gl.clearColor(0.0, 0.0, 0.0, 1.0);
	Matrix4 viewMatrix = makePerspectiveMatrix(70, canvas.width/canvas.height, 0.1, 100.0);

	var viewUniform = gl.getUniformLocation(shader.shaderProgram, 'viewMatrix');
	gl.uniformMatrix4fv(viewUniform, false, viewMatrix.storage);

	Matrix4 cameraMatrix = new Matrix4.identity();
	cameraMatrix.translate(-cameraX, cameraZ, -12.0);
	cameraMatrix.rotateX(90.0 * (Math.PI / 180.0));
	gl.uniformMatrix4fv(cameraMatrixUniform, false, cameraMatrix.storage);

	for(int i = 0; i < level.length; i++) {
		level[i].render();
	}

	Matrix4 modelMatrix = new Matrix4.identity();
	modelMatrix.translate(0.0, 0.0, 0.0);
	gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
	playerTexture.bind();
	playerSwing[animationFrame.floor()].render();

	modelMatrix = new Matrix4.identity();
	modelMatrix.translate(0.0, 0.0, 2.0);
	gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
	playerTexture.bind();
	playerWalk[animationFrameWalk.floor()].render();
}

void tick () {

	animationFrame += 0.5;
	if(animationFrame >= 8.0)animationFrame = 0.0;
	animationFrameWalk += 0.125;
	if(animationFrameWalk >= 6.0)animationFrameWalk = 0.0;

	rotation += 0.01;
	if(keysDown[LEFT]) cameraX -= 0.1;
	if(keysDown[RIGHT]) cameraX += 0.1;
	if(keysDown[UP]) cameraZ -= 0.1;
	if(keysDown[DOWN]) cameraZ += 0.1;
}

void main () {

	print('Hello World!');
	canvas = new Canvas();

	gl.enable(GL.DEPTH_TEST);
	gl.depthFunc(GL.LESS);
	gl.enable(GL.BLEND);
	gl.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);

	shader = new Shader();
	vertexPositionAttribute = shader.createAttribute('vertexPosition');
	textureCoordAttribute = shader.createAttribute('textureCoord');
	modelViewMatrixUniform = shader.createUniform('modelViewMatrix');
	cameraMatrixUniform = shader.createUniform('cameraMatrix');

	stone1 = new Texture1('src/stone1.png');
	stone2 = new Texture1('src/stone2.png');
	stoneSlab = new Texture1('src/stoneSlab.png');
	stoneCracked = [
		new Texture1('src/stoneCracked.png'),
		new Texture1('src/stoneCracked2.png'),
		new Texture1('src/stoneCracked3.png'),
	];
	playerTexture = new Texture1('src/player.png');

	createPlayerBuffer();

	keysPressed.fillRange(0, keysPressed.length, false);
	keysDown.fillRange(0, keysDown.length, false);

	createLevel();

	canvas.runFunc(run);
}

void keyDown (KeyboardEvent e) {
	if(e.keyCode<keysDown.length && !keysDown[e.keyCode]) {
		keysDown[e.keyCode]= true;
		keysPressed[e.keyCode]= true;
	}
}

void keyUp (KeyboardEvent e) {
	if(e.keyCode<keysDown.length) keysDown[e.keyCode]= false;
}