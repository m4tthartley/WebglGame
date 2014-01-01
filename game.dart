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

GL.RenderingContext gl;
Canvas canvas;
Shader shader;

var vertexPositionAttribute;
var textureCoordAttribute;
var modelViewMatrixUniform;
var cameraMatrixUniform;

Texture1 wall;

Buffer asd = new Buffer(
	/*Vertices*/
	[
		-0.5, -0.5, 0.0,
		-0.5, 0.5, 0.0,
		0.5, 0.5, 0.0,
		0.5, -0.5, 0.0,
	],
	/*Idices*/
	[
		0, 1, 2,
		0, 2, 3,
	],
	/*Colors*/
	[],
	/*Texture coords*/
	[
		0.0, 1.0,
		0.0, 0.0,
		1.0, 0.0,
		1.0, 1.0,
	]
);

double rotation = 0.0;

void run (double time) {

	rotation += 0.01;

	gl.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
	gl.clearColor(0.0, 0.0, 0.0, 1.0);
	Matrix4 viewMatrix = makePerspectiveMatrix(70, canvas.width/canvas.height, 0.1, 100.0);

	var viewUniform = gl.getUniformLocation(shader.shaderProgram, 'viewMatrix');
	gl.uniformMatrix4fv(viewUniform, false, viewMatrix.storage);

	Matrix4 cameraMatrix = new Matrix4.identity();
	//cameraMatrix.translate(0.0, -4.0, 0.0);
	cameraMatrix.rotateX(90.0 * (Math.PI / 180.0));
	//cameraMatrix.rotateZ(rotation);
	gl.uniformMatrix4fv(cameraMatrixUniform, false, cameraMatrix.storage);

	Matrix4 modelMatrix = new Matrix4.identity();
	modelMatrix.translate(0.0, -4.0, -1.0);
	//modelMatrix.rotateX(rotation);
	//modelMatrix.rotateZ(rotation);
	//gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
	shader.setUniform(modelViewMatrixUniform, modelMatrix);
	wall.bind();
	asd.render();

	modelMatrix = new Matrix4.identity();
	modelMatrix.translate(0.0, -4.0, 1.0);
	gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
	wall.bind();
	asd.render();

	canvas.runFunc(run);
}

void main () {

	print('Hello World!');
	canvas = new Canvas();
	shader = new Shader();
	vertexPositionAttribute = shader.createAttribute('vertexPosition');
	textureCoordAttribute = shader.createAttribute('textureCoord');
	modelViewMatrixUniform = shader.createUniform('modelViewMatrix');
	cameraMatrixUniform = shader.createUniform('cameraMatrix');

	wall = new Texture1('src/wall.png');

	canvas.runFunc(run);
}