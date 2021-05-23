# IsoMAZEtric
A Godot 2.5D game using isometric 1-bit pixel art. Maze puzzles revolving around interpreting isometric projections.

## Description
Technically the project is not isometric, but rather dimetric: a slightly different type of axonometric projection.

The art used for this project was procedurally generated by my related project [ProceduralPixelArt](https://github.com/jlcarr/ProceduralPixelArt).

### The Projection Problem
#### Introduction to the Projection
The projection is actually a **dimetric** projection, as opposed to a truly isometric one (See my ProceduralPixelArt project for details).  
To allow the objects in game to exist in the correct position for their projection.  

#### Godot's Camera
In Godot the camera's matrix can be obtained by the `get_camera_transform()` method, however it cannot be set directly.  
In the UI the camera's relevant settings are `Projection` (which should be set to Orthogonal, i.e. `PROJECTION_ORTHOGONAL`)
In Godot the `Camera` objects inherit from the `Spacial` class, which has the following properties:
   - `translation` which is the cartesian translation.
   - `rotation_degrees` which are the Euler XYZ-angles of rotation

NOTE: the `scale` property has no effects on cameras in Godot. The `Spacial` transform of the camera appears to be different from the camera matrix by the scaling factor.

#### Mathematical Description of Godot's Orthogonal Camera Transform
So based upon these available transforms, what kinds of camera matrices can be built? Can we build the projection matrix desired from the camera's translation and rotation parameters?  
If we ignore the Euler Z angle (unneeded for the projection we're looking for) then we can describe our transform in terms of the following basis transform, plus a translation:

![R_{y}R_{x}=\begin{bmatrix}\cos(\theta)&0&\sin(\theta)\\0&1&0\\-\sin(\theta)&0&\cos(\theta)\end{bmatrix}\begin{bmatrix}1&0&0\\0&\cos(\phi)&-\sin(\phi)\\0&\sin(\phi)&\cos(\phi)\end{bmatrix}=\begin{bmatrix}\cos(\theta)&\sin(\theta)\sin(\phi)&\sin(\theta)\cos(\phi)\\0&\cos(\phi)&-\sin(\phi)\\-\sin(\theta)&\cos(\theta)\sin(\phi)&\cos(\theta)\cos(\phi)\end{bmatrix}](https://render.githubusercontent.com/render/math?math=R_%7By%7DR_%7Bx%7D%3D%0A%5Cbegin%7Bbmatrix%7D%5Ccos%28%5Ctheta%29%260%26%5Csin%28%5Ctheta%29%5C%5C0%261%260%5C%5C-%5Csin%28%5Ctheta%29%260%26%5Ccos%28%5Ctheta%29%5Cend%7Bbmatrix%7D%20%0A%5Cbegin%7Bbmatrix%7D1%260%260%5C%5C0%26%5Ccos%28%5Cphi%29%26-%5Csin%28%5Cphi%29%5C%5C0%26%5Csin%28%5Cphi%29%26%5Ccos%28%5Cphi%29%5Cend%7Bbmatrix%7D%3D%0A%5Cbegin%7Bbmatrix%7D%5Ccos%28%5Ctheta%29%26%5Csin%28%5Ctheta%29%5Csin%28%5Cphi%29%26%5Csin%28%5Ctheta%29%5Ccos%28%5Cphi%29%5C%5C0%26%5Ccos%28%5Cphi%29%26-%5Csin%28%5Cphi%29%5C%5C-%5Csin%28%5Ctheta%29%26%5Ccos%28%5Ctheta%29%5Csin%28%5Cphi%29%26%5Ccos%28%5Ctheta%29%5Ccos%28%5Cphi%29%5Cend%7Bbmatrix%7D)

Using our knowledge of spherical coordinates it's not hard to see the angles should be *phi* = *-asin(1/sqrt(3))* = −35.264deg and *theta* = 45deg. Substituting this in we get the following result:

![R_{y}R_{x}=\begin{bmatrix}\frac{1}{\sqrt{2}}&-\frac{1}{\sqrt{6}}&\frac{1}{\sqrt{3}}\\0&\frac{\sqrt{2}}{\sqrt{3}}&\frac{1}{\sqrt{3}}\\-\frac{1}{\sqrt{2}}&-\frac{1}{\sqrt{6}}&\frac{1}{\sqrt{3}}\end{bmatrix}=\begin{bmatrix}0.707&-0.408&0.577\\0&0.816&0.577\\-0.707&-0.408&0.577\end{bmatrix}](https://render.githubusercontent.com/render/math?math=R_%7By%7DR_%7Bx%7D%3D%0A%5Cbegin%7Bbmatrix%7D%5Cfrac%7B1%7D%7B%5Csqrt%7B2%7D%7D%26-%5Cfrac%7B1%7D%7B%5Csqrt%7B6%7D%7D%26%5Cfrac%7B1%7D%7B%5Csqrt%7B3%7D%7D%5C%5C0%26%5Cfrac%7B%5Csqrt%7B2%7D%7D%7B%5Csqrt%7B3%7D%7D%26%5Cfrac%7B1%7D%7B%5Csqrt%7B3%7D%7D%5C%5C-%5Cfrac%7B1%7D%7B%5Csqrt%7B2%7D%7D%26-%5Cfrac%7B1%7D%7B%5Csqrt%7B6%7D%7D%26%5Cfrac%7B1%7D%7B%5Csqrt%7B3%7D%7D%5Cend%7Bbmatrix%7D%3D%0A%5Cbegin%7Bbmatrix%7D0.707%26-0.408%260.577%5C%5C0%260.816%260.577%5C%5C-0.707%26-0.408%260.577%5Cend%7Bbmatrix%7D)

Testing these values in Godot along with `print(camera.get_camera_transform())` and `print(camera.transform)` we can see it the results match.  

We can do this math pretty easily with Sympy (consider trying the `sympy.latex(expression)` function!):
```python
import sympy

theta, phi = sympy.symbols('theta phi')

R_y = sympy.Matrix([
    [sympy.cos(theta), 0, sympy.sin(theta)],
    [0, 1, 0],
    [-sympy.sin(theta), 0, sympy.cos(theta)],
])
R_x = sympy.Matrix([
    [1, 0, 0],
    [0, sympy.cos(phi), -sympy.sin(phi)],
    [0, sympy.sin(phi), sympy.cos(phi)],
])

camera_transform = R_y * R_x
filled_camera_transform = camera_transform.subs([
	(theta, sympy.pi/4), 
	(phi, -sympy.asin(1/sympy.sqrt(3)))
])
sympy.N(filled_camera_transform)
```

Bad news though: this does not match the desired projection matrix from the dimetric pixel-perfect art (matrix adjusted for row-vector form, and y being the veritical axis):

![\begin{bmatrix}1&-\frac{1}{2}\\0&1\\-1&-\frac{1}{2}\end{bmatrix}](https://render.githubusercontent.com/render/math?math=%5Cbegin%7Bbmatrix%7D1%26-%5Cfrac%7B1%7D%7B2%7D%5C%5C0%261%5C%5C-1%26-%5Cfrac%7B1%7D%7B2%7D%5Cend%7Bbmatrix%7D)

#### Possible Solutions to Godot's Camera
What can we do? Well to get the matrices to match we need an isotropic scaling factor of `sqrt(2)`, and on top of that a verical stretch of `sqrt(3)`. Here are 3 options:
- Fiddle with viewport size and resolution so obtain the desired stretch.
   - This would probably be the easiest and require the fewest changes.
- Apply the stretch to the actual game world.
   - This ones is probably the second easiest, but also quite silly. Also doesn't seem to be friendly towards stretching some collision shapes.
- Write a shader that will "disconnect" the physical game world from the rendered screen and produce the desired projection.
   - This one is the most proper solution, provides the most control, and is of course also the hardest.

### The Projection Solution
#### Procedural Pixel
- `x = 9`
- `l = 2`
#### Camera Settings
- `projection = PROJECTION_ORTHOGONAL`
- `translation = Vector3(20, 20, 20)`
- `rotation_degrees = Vector3(-35.26, 45, 0)`
- `size = 32`

#### Window Settings
- `display/window/size/width = 656`
- `display/window/size/height = 656`
- `display/window/size/resizable = false`
- `display/window/stretch/shrink = 2`

#### Cubes
- Mesh: `size = Vector3(2, 2, 2)`
- Collision Shape: `extents = Vector3(1, 1, 1)`

#### The Spacial Shader
This is the star of the show.
The **vertex shader** corrects the vertices to the applying the missing stretch factor to the projection matrix.
The **frament shader** is then set up to select the pixels from the texture so as to project the image in pixel-perfect placement.

## Reference
### Projection Math
- https://en.wikipedia.org/wiki/Axonometric_projection
- https://en.wikipedia.org/wiki/Camera_matrix
- https://en.wikipedia.org/wiki/Spherical_coordinate_system

### Rotations Math
- https://en.wikipedia.org/wiki/Rotation_matrix
- https://en.wikipedia.org/wiki/Euler_angles
- https://en.wikipedia.org/wiki/Spherical_coordinate_system


### Godot
- https://docs.godotengine.org/en/stable/classes/class_spatial.html
- https://docs.godotengine.org/en/stable/classes/class_camera.html
- https://docs.godotengine.org/en/stable/tutorials/shading/shading_reference/shading_language.html
- https://docs.godotengine.org/en/stable/tutorials/shading/shading_reference/spatial_shader.html

### 2.5D
- Official Godot 2.5D plugin: https://godotengine.org/asset-library/asset/583
- https://www.reddit.com/r/godot/comments/mcqzwc/almost_perfect_pixel_perfect_25d_pixelart_demo/
- https://gamefiddler.com/isometric-pixel-art-in-blender/

### Shaders
- Outline shader: https://roystan.net/articles/outline-shader.html

## TODO
- Dark mode
- Loading noise shader
- Final victory scene
- Levels design
- Consider level name: Shift In Perspective
