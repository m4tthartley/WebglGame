part of game;

class Buffer {

	var vertexBuffer;
	var indexBuffer;
	var textureBuffer;

	var vertices;
	var indices;
	var colors;
	var texture;

	Buffer (/*var gl,*/ this.vertices, this.indices, this.colors, this.texture) {

		Float32List vertexList = new Float32List(vertices.length);
		for(int i = 0; i < vertices.length/3; i++) {
			vertexList.setAll(i*3, [
				vertices[i*3],
				vertices[i*3+1],
				vertices[i*3+2]
			]);
		}

		Int16List indexList = new Int16List(indices.length);
		indexList.setAll(0, indices);

		Float32List textureCoords = new Float32List(texture.length);
		for(int i = 0; i < texture.length/2; i++) {
			textureCoords.setAll(i*2, [ texture[i*2], texture[i*2+1] ]);
		}

		vertexBuffer = gl.createBuffer();
		gl.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
		gl.bufferDataTyped(GL.ARRAY_BUFFER, vertexList, GL.STATIC_DRAW);
		//gl.vertexAttribPointer(vertexPositionAttribute, 3, GL.FLOAT, false, 0, 0);

		indexBuffer = gl.createBuffer();
		gl.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, indexBuffer);
		gl.bufferDataTyped(GL.ELEMENT_ARRAY_BUFFER, indexList, GL.STATIC_DRAW);

		textureBuffer = gl.createBuffer();
		gl.bindBuffer(GL.ARRAY_BUFFER, textureBuffer);
		gl.bufferDataTyped(GL.ARRAY_BUFFER, textureCoords, GL.STATIC_DRAW);
		//gl.vertexAttribPointer(textureCoordAttribute, 2, GL.FLOAT, false, 0, 0);
	}

	void render (/*var gl, var shader, var modelMatrix, var modelViewUniform*/) {

		//gl.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
		//gl.vertexAttribPointer(vertexPositionAttribute, 3, GL.FLOAT, false, 0, 0);
		//gl.bindBuffer(GL.ARRAY_BUFFER, textureBuffer);
		//gl.vertexAttribPointer(textureCoordAttribute, 2, GL.FLOAT, false, 0, 0);

		shader.setAttribute(vertexBuffer, vertexPositionAttribute, 3);
		shader.setAttribute(textureBuffer, textureCoordAttribute, 2);

//		Matrix4 modelMatrix = new Matrix4.identity();
//		modelMatrix.translate(0.0, 0.0, -3.0);
//		gl.uniformMatrix4fv(shader.modelViewLocation, false, modelMatrix.storage);
		gl.drawElements(GL.TRIANGLES, indices.length, GL.UNSIGNED_SHORT, 0);
	}

}