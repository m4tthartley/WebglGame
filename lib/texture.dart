part of game;

class Texture1 {

	ImageElement image;
	var texture;

	Texture1 (String file) {

		image = new ImageElement();
		image.src = file;
		texture = gl.createTexture();

		image.onLoad.listen(
			(e) {
				gl.bindTexture(GL.TEXTURE_2D, texture);
				gl.texImage2DImage(GL.TEXTURE_2D, 0, GL.RGBA, GL.RGBA, GL.UNSIGNED_BYTE, image);
				gl.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
	      		gl.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);
				gl.generateMipmap(GL.TEXTURE_2D);
				gl.bindTexture(GL.TEXTURE_2D, null);
				print(file + ' has been loaded');
			}
		);
	}

	void bind () {

		gl.activeTexture(GL.TEXTURE0);
		gl.bindTexture(GL.TEXTURE_2D, texture);
		gl.uniform1i(gl.getUniformLocation(shader.shaderProgram, 'uSampler'), 0);
	}

}