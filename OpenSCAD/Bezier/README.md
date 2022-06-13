# Draw a Boat, with Bezier curves.
This is a test, a use-case, which is the OpenSCAD counterpart of the Java project at <https://github.com/OlivierLD/raspberry-coffee/tree/master/Project-Trunk/BoatDesign>, using Swing to render the data.
The Bezier implementation is also made in Java in this case.

Considering that:
- STL is a standard for 3D rendering
- OpenSCAD can generate STL files, much more naturally than Java

It would be great to use OpenSCAD to render the boat designs in 3D.  
The thing is that all the hydrostatic calculations are easier to implement in Java, this is certainly not the job of a language like OpenSCAD...

So the idea is the following one:
- As the boat design is entirely driven by a couple of control points, we could do the required calculations in Java, along with a minimal Swing rendering.
- Once the hydrostatic calculations are satifying, we can generate/export the coordinates of the control points, and use them from OpenSCAD to generate and render the STL files.

We use the following files in OpenSCAD:
- `Bezier.scad`, to implement the fundamental 3D Bezier methods.
- `BoatDesign.scad`, to implement a generic boat design, based on 2 3D Bezier curves, one for the rail(s), one for the keel. This file uses `Bezier.scad`.
- Then, files like `SmallBoat550.scad`, `Outrigger.scad`, `Tri.914.scad` are examples of design implementation, implemented as OpenSCAD modules. Those files can be used to generate STL models.
    - Those files can use parameter files, containing the definition of the rails and keel, as arrays of points. See `SmallBoat.550.prms.scad`, `tri.914.scad`, `outrigger.prms.scad`, etc.
    - For example, the `SmallBoat.550.scad` comes down to
    ```openscad
    use <./Bezier.scad>
    use <./BoatDesign.scad>

    include <./SmallBoat.550.prms.scad>

    module SmallBoat550(withBeams=true, withColor=true) {
        BoatDesign(extVolume, rail, keel, withBeams, withColor);
    }

    SmallBoat550(true, true);    
    ```
    - `FullTri.scad` even uses several of those modules on the same model, as a more complex example.

> See in the files above how they use the `use` and `include` directives to refer to each other.

> _Note_: The smoothing of the modules (hulls, roofs, etc) is driven by the variable `DEFAULT_BEZIER_T_STEP` in `BoatDesign.scad`. This will
> define the `t` step increment for the Bezier elaboration. Going below `0.005` seems to be too demanding.  
> In the code above, `BoatDesign(extVolume, rail, keel, withBeams, withColor);`, the `BoatDesign` module actually takes an extra parameter named `bezierTStep`, its default value is `DEFAULT_BEZIER_T_STEP`. It can be overridden, like this:  
> ```openscad
> BoatDesign(extVolume, rail, keel, withBeams, withColor, 0.025);
> ```

Can be rendered in [TinkerCad](https://www.tinkercad.com/things/5Be9yKQkFRr-la-tete-a-toto)...

## TODO
- Add roofs, cockpits, panels, rudders, etc
- Add rigging and sails

---

https://www.tinkercad.com/things/5Be9yKQkFRr-la-tete-a-toto
