part of game;

List<Tile> level = new List<Tile>();

var layoutSize = 16;
var layout = [
	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0,
	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
];

class Tile {

	double x;
	double z;
	int index;
	Texture1 texture;
	bool backWall = false;
	bool frontWall = false;
	bool leftWall = false;
	bool rightWall = false;

	Tile (this.x, this.z, this.index) {
	}

	void render () {

		Matrix4 modelMatrix = new Matrix4.identity();
		modelMatrix.translate(x, 0.0, z);
		gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
		texture.bind();
		floor.render();

		if(backWall) {
			modelMatrix = new Matrix4.identity();
			modelMatrix.translate(x, 0.5, z-0.5);
			gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
			stone2.bind();
			wall.render();

			/*modelMatrix = new Matrix4.identity();
			modelMatrix.translate(x, 1.5, z-0.5);
			gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
			stone2.bind();
			wall.render();*/
		}

		if(frontWall) {
			modelMatrix = new Matrix4.identity();
			modelMatrix.translate(x, 0.5, z+0.5);
			gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
			stone2.bind();
			wall.render();
		}

		if(leftWall) {
			modelMatrix = new Matrix4.identity();
			modelMatrix.translate(x-0.5, 0.5, z);
			modelMatrix.rotateY(90.0 * (Math.PI / 180.0));
			gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
			stone2.bind();
			wall.render();
		}

		if(rightWall) {
			modelMatrix = new Matrix4.identity();
			modelMatrix.translate(x+0.5, 0.5, z);
			modelMatrix.rotateY(-90.0 * (Math.PI / 180.0));
			gl.uniformMatrix4fv(modelViewMatrixUniform, false, modelMatrix.storage);
			stone2.bind();
			wall.render();
		}
	}

}

void createLevel () {

	for(int i = 0; i < layout.length; i++) {

		if(layout[i] == 1) {
			level.add( new Tile( (i.toDouble()%layoutSize)-(layoutSize/2), (i/layoutSize).floor()-(layoutSize/2), i ) );
		}
	}

	for(int i = 0; i < level.length; i++) {

		var backIndex = level[i].index - layoutSize;
		var frontIndex = level[i].index + layoutSize;
		var leftIndex = level[i].index - 1;
		var rightIndex = level[i].index + 1;

		if(backIndex < 0 || layout[backIndex] == 0) level[i].backWall = true;
		if(frontIndex >= layout.length || layout[frontIndex] == 0) level[i].frontWall = true;
		if(leftIndex < 0 || layout[leftIndex] == 0) level[i].leftWall = true;
		if(rightIndex >= layout.length || layout[rightIndex] == 0) level[i].rightWall = true;

		var rnum = rand.nextInt(10);
		if(rnum == 9) level[i].texture = stoneCracked[rand.nextInt(3)];
		else level[i].texture = stoneSlab;
	}
}