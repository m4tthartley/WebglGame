part of game;

class Shader {

	var shaderProgram;

//	var vertexPositionAttribute;
//	var textureCoordAttribute;
//
//	var modelViewLocation;

	Shader () {

		var vertexShader = '''
			attribute vec3 vertexPosition;
			attribute vec2 textureCoord;
	
			varying lowp vec4 color;
			varying highp vec2 vTextureCoord;
	
			uniform mat4 modelViewMatrix;
			uniform mat4 viewMatrix;
			uniform mat4 cameraMatrix;
	
			void main (void) {
				
				gl_Position = viewMatrix * cameraMatrix * modelViewMatrix * vec4(vertexPosition, 1.0);
				color = vec4(0.5, 1.0, 0.5, 1.0);
				vTextureCoord = textureCoord;
			}
		''';

		var fragmentShader = '''
			varying lowp vec4 color;
			varying highp vec2 vTextureCoord;
	
			uniform sampler2D uSampler;
	
			void main (void) {
	
				gl_FragColor = texture2D(uSampler, vTextureCoord);
				//gl_FragColor = color;
				if(gl_FragColor.a < 0.1) discard;
			}
		''';

		var vShader = gl.createShader(GL.VERTEX_SHADER);
		gl.shaderSource(vShader, vertexShader);
		gl.compileShader(vShader);
		if (!gl.getShaderParameter(vShader, GL.COMPILE_STATUS)) {
	  		print('vertex shader error: ' + gl.getShaderInfoLog(vShader));
		}

		var fShader = gl.createShader(GL.FRAGMENT_SHADER);
		gl.shaderSource(fShader, fragmentShader);
		gl.compileShader(fShader);
		if (!gl.getShaderParameter(fShader, GL.COMPILE_STATUS)) {
	  		print('fragment shader error: ' + gl.getShaderInfoLog(fShader));
		}

		shaderProgram = gl.createProgram();
		gl.attachShader(shaderProgram, vShader);
		gl.attachShader(shaderProgram, fShader);
		gl.linkProgram(shaderProgram);
		if(!gl.getProgramParameter(shaderProgram, GL.LINK_STATUS)) print('No shaders!');

		gl.useProgram(shaderProgram);

//		vertexPositionAttribute = gl.getAttribLocation(shaderProgram, 'vertexPosition');
//		gl.enableVertexAttribArray(vertexPositionAttribute);
//		textureCoordAttribute = gl.getAttribLocation(shaderProgram, 'textureCoord');
//		gl.enableVertexAttribArray(textureCoordAttribute);
//
//		modelViewLocation = gl.getUniformLocation(shaderProgram, 'modelViewMatrix');
	}

	createAttribute (String name) {

		var attribute = gl.getAttribLocation(shaderProgram, name);
		gl.enableVertexAttribArray(attribute);
		return attribute;
	}

	setAttribute (var buffer, var attribute, var vertexSize) {

		gl.bindBuffer(GL.ARRAY_BUFFER, buffer);
		gl.vertexAttribPointer(attribute, vertexSize, GL.FLOAT, false, 0, 0);
	}

	createUniform (String name) => gl.getUniformLocation(shaderProgram, name);

	setUniform (var uniform, var matrix) {

		gl.uniformMatrix4fv(uniform, false, matrix.storage);
	}

}