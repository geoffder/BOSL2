//////////////////////////////////////////////////////////////////////
// LibFile: joiners.scad
//   Modules for joining separately printed parts including screw together, snap-together and dovetails. 
// Includes:
//   include <BOSL2/std.scad>
//   include <BOSL2/joiners.scad>
// FileGroup: Parts
// FileSummary: Joiner shapes for connecting separately printed objects.
//////////////////////////////////////////////////////////////////////


include <rounding.scad>


// Section: Half Joiners


// Function&Module: half_joiner_clear()
// Usage: As Module
//   half_joiner_clear(l, w, [ang=], [clearance=], [overlap=]) [ATTACHMENTS];
// Usage: As Function
//   vnf = half_joiner_clear(l, w, [ang=], [clearance=], [overlap=]);
// Topics: Joiners, Parts
// Description:
//   Creates a mask to clear an area so that a half_joiner can be placed there.
// Arguments:
//   l = Length of the joiner to clear space for.
//   w = Width of the joiner to clear space for.
//   ang = Overhang angle of the joiner.
//   ---
//   clearance = Extra width to clear.
//   overlap = Extra depth to clear.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// See Also: half_joiner_clear(), half_joiner(), half_joiner2(), joiner_clear(), joiner()
// Example:
//   half_joiner_clear();
function half_joiner_clear(l=20, w=10, ang=30, clearance=0, overlap=0.01, anchor=CENTER, spin=0, orient=UP) =
    let(
        guide = [w/3-get_slop()*2, ang_adj_to_opp(ang, l/3)*2, l/3],
        path = [
            [ l/2,-overlap], [ guide.z/2, -guide.y/2-overlap],
            [-guide.z/2, -guide.y/2-overlap], [-l/2,-overlap],
            [-l/2, overlap], [-guide.z/2,  guide.y/2+overlap],
            [ guide.z/2,  guide.y/2+overlap], [ l/2, overlap],
        ],
        dpath = deduplicate(path, closed=true),
        vnf = linear_sweep(dpath, height=w+clearance*2, center=true, spin=90, orient=RIGHT)
    ) reorient(anchor,spin,orient, vnf=vnf, p=vnf);

module half_joiner_clear(l=20, w=10, ang=30, clearance=0, overlap=0.01, anchor=CENTER, spin=0, orient=UP)
{
    vnf = half_joiner_clear(l=l, w=w, ang=ang, clearance=clearance, overlap=overlap);
    attachable(anchor,spin,orient, vnf=vnf) {
        vnf_polyhedron(vnf, convexity=2);
        children();
    }
}


// Function&Module: half_joiner()
// Usage: As Module
//   half_joiner(l, w, [base=], [ang=], [screwsize=], [$slop=]) [ATTACHMENTS];
// Usage: As Function
//   vnf = half_joiner(l, w, [base=], [ang=], [screwsize=], [$slop=]);
// Topics: Joiners, Parts
// Description:
//   Creates a half_joiner object that can be attached to a matching half_joiner2 object.
// Arguments:
//   l = Length of the half_joiner.
//   w = Width of the half_joiner.
//   ---
//   base = Length of the backing to the half_joiner.
//   ang = Overhang angle of the half_joiner.
//   screwsize = If given, diameter of screwhole.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//   $slop = Printer specific slop value to make parts fit more closely.
// See Also: half_joiner_clear(), half_joiner(), half_joiner2(), joiner_clear(), joiner()
// Examples(FlatSpin,VPD=75):
//   half_joiner(screwsize=3);
//   half_joiner(l=20,w=10,base=10);
// Example(3D):
//   diff()
//   cuboid(30)
//       attach([FWD,TOP,RIGHT])
//           xcopies(30) half_joiner();
function half_joiner(l=20, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP) =
    let(
        guide = [w/3-get_slop()*2, ang_adj_to_opp(ang, l/3)*2, l/3],
        snap_h = 1,
        snap = [guide.x+snap_h, 2*snap_h, l*0.6],
        slope = guide.z/2/(w/8),
        snap_top = slope * (snap.x-guide.x)/2,

        verts = [
            [-w/2,-base,-l/2], [-w/2,-base,l/2], [w/2,-base,l/2], [w/2,-base,-l/2],

            [-w/2, 0,-l/2],
            [-w/2,-guide.y/2,-guide.z/2],
            [-w/2,-guide.y/2, guide.z/2],
            [-w/2, 0,l/2],
            [ w/2, 0,l/2],
            [ w/2,-guide.y/2, guide.z/2],
            [ w/2,-guide.y/2,-guide.z/2],
            [ w/2, 0,-l/2],

            [-guide.x/2, 0,-l/2],
            [-guide.x/2,-guide.y/2,-guide.z/2],
            [-guide.x/2-w/8,-guide.y/2, 0],
            [-guide.x/2,-guide.y/2, guide.z/2],
            [-guide.x/2, 0,l/2],
            [ guide.x/2, 0,l/2],
            [ guide.x/2,-guide.y/2, guide.z/2],
            [ guide.x/2+w/8,-guide.y/2, 0],
            [ guide.x/2,-guide.y/2,-guide.z/2],
            [ guide.x/2, 0,-l/2],

            [-w/6, -snap.y/2, -snap.z/2],
            [-w/6, -snap.y/2, -guide.z/2],
            [-snap.x/2, 0, snap_top-guide.z/2],
            [-w/6,  snap.y/2, -guide.z/2],
            [-w/6,  snap.y/2, -snap.z/2],
            [-snap.x/2, 0, snap_top-snap.z/2],

            [-w/6, -snap.y/2, snap.z/2],
            [-w/6, -snap.y/2, guide.z/2],
            [-snap.x/2, 0, guide.z/2-snap_top],
            [-w/6,  snap.y/2, guide.z/2],
            [-w/6,  snap.y/2, snap.z/2],
            [-snap.x/2, 0, snap.z/2-snap_top],

            [ w/6, -snap.y/2, snap.z/2],
            [ w/6, -snap.y/2, guide.z/2],
            [ snap.x/2, 0, guide.z/2-snap_top],
            [ w/6,  snap.y/2, guide.z/2],
            [ w/6,  snap.y/2, snap.z/2],
            [ snap.x/2, 0, snap.z/2-snap_top],

            [ w/6, -snap.y/2, -snap.z/2],
            [ w/6, -snap.y/2, -guide.z/2],
            [ snap.x/2, 0, snap_top-guide.z/2],
            [ w/6,  snap.y/2, -guide.z/2],
            [ w/6,  snap.y/2, -snap.z/2],
            [ snap.x/2, 0, snap_top-snap.z/2],

            [-w/6, guide.y/2, -guide.z/2],
            [-guide.x/2-w/8, guide.y/2, 0],
            [-w/6, guide.y/2,  guide.z/2],
            [ w/6, guide.y/2,  guide.z/2],
            [ guide.x/2+w/8, guide.y/2, 0],
            [ w/6, guide.y/2, -guide.z/2],

            if (screwsize != undef) each [
                for (a = [0:45:359]) [guide.x/2+w/8, 0, 0] + screwsize * 1.1 / 2 * [-abs(sin(a))/slope, cos(a), sin(a)],
                for (a = [0:45:359]) [-(guide.x/2+w/8), 0, 0] + screwsize * 1.1 / 2 * [abs(sin(a))/slope, cos(a), sin(a)],
            ]
        ],
        faces = [
            [0,1,2], [2,3,0],

            [0,4,5], [0,5,6], [0,6,1], [1,6,7],
            [3,10,11], [3,9,10], [2,9,3], [2,8,9],

            [1,7,16], [1,16,17], [1,17,8], [1,8,2],
            [0,3,11], [0,11,21], [0,21,12], [0,12,4],

            [10,20,11], [20,21,11],
            [12,13,5], [12,5,4],
            [9,8,18], [17,18,8],
            [6,16,7], [6,15,16],

            [19,10,9], [19,9,18], [19,20,10],
            [6,14,15], [6,5,14], [5,13,14],

            [24,26,25], [26,24,27],
            [22,27,24], [22,24,23],
            [22,26,27],

            [30,32,33], [30,31,32],
            [30,33,28], [30,28,29],
            [32,28,33],

            [40,41,42], [40,42,45],
            [45,42,43], [43,44,45],
            [40,45,44],

            [36,38,37], [36,39,38],
            [36,35,34], [36,34,39],
            [39,34,38],

            [12,26,22], [12,22,13], [22,23,13], [12,46,26], [46,25,26],
            [16,28,32], [16,15,28], [15,29,28], [48,16,32], [32,31,48],
            [17,38,34], [17,34,18], [18,34,35], [49,38,17], [37,38,49],
            [21,40,44], [51,21,44], [43,51,44], [20,40,21], [20,41,40],

            [17,16,49], [49,16,48],
            [21,51,46], [46,12,21],

            [51,50,49], [48,47,46], [46,51,49], [46,49,48],

            if (screwsize == undef) each [
                [19,36,50], [19,35,36], [19,18,35], [36,37,50], [49,50,37],
                [19,50,42], [19,42,41], [41,20,19], [50,43,42], [50,51,43],
                [14,24,47], [14,23,24], [14,13,23], [47,24,25], [46,47,25],
                [47,30,14], [14,30,29], [14,29,15], [47,31,30], [47,48,31],
            ] else each [
                [20,19,56], [20,56,57], [20,57,58], [20,58,42], [20,42,41],
                [50,51,52], [51,59,52], [51,58,59], [51,42,58], [51,43,42],
                [49,50,52], [49,52,53], [49,53,54], [49,54,36], [49,36,37],
                [56,19,18], [18,55,56], [18,54,55], [18,36,54], [18,35,36],
                [14,64,15], [15,64,63], [15,63,62], [15,62,30], [15,30,29],
                [48,31,30], [48,30,62], [48,62,61], [48,61,60], [60,47,48],
                [13,23,24], [13,24,66], [13,66,65], [13,65,64], [64,14,13],
                [46,47,60], [46,60,67], [46,67,66], [46,66,24], [46,24,25],
                for (i=[0:7]) let(b=52) [b+i, b+8+i, b+8+(i+1)%8],
                for (i=[0:7]) let(b=52) [b+i, b+8+(i+1)%8, b+(i+1)%8],
            ],
        ],
        pvnf = [verts, faces],
        vnf = xrot(90, p=pvnf)
    ) reorient(anchor,spin,orient, size=[w,l,base*2], p=vnf);

module half_joiner(l=20, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP)
{
    vnf = half_joiner(l=l, w=w, base=base, ang=ang, screwsize=screwsize);
    if (in_list("remove",$tags_shown)) {
        attachable(anchor,spin,orient, size=[w,l,base*2], $tags="remove") {
            half_joiner_clear(l=l, w=w, ang=ang, clearance=1);
            union();
        }
    } else {
        attachable(anchor,spin,orient, size=[w,base*2,l], $tags="keep") {
            vnf_polyhedron(vnf, convexity=12);
            children();
        }
    }
}


// Function&Module: half_joiner2()
// Usage: As Module
//   half_joiner2(l, w, [base=], [ang=], [screwsize=])
// Usage: As Function
//   vnf = half_joiner2(l, w, [base=], [ang=], [screwsize=])
// Topics: Joiners, Parts
// Description:
//   Creates a half_joiner2 object that can be attached to half_joiner object.
// Arguments:
//   l = Length of the half_joiner.
//   w = Width of the half_joiner.
//   ---
//   base = Length of the backing to the half_joiner.
//   ang = Overhang angle of the half_joiner.
//   screwsize = Diameter of screwhole.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// See Also: half_joiner_clear(), half_joiner(), half_joiner2(), joiner_clear(), joiner()
// Examples(FlatSpin,VPD=75):
//   half_joiner2(screwsize=3);
//   half_joiner2(w=10,base=10,l=20);
// Example(3D):
//   diff()
//   cuboid(30)
//       attach([FWD,TOP,RIGHT])
//           xcopies(30) half_joiner2();
function half_joiner2(l=20, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP) =
    let(
        guide = [w/3, ang_adj_to_opp(ang, l/3)*2, l/3],
        snap_h = 1,
        snap = [guide.x+snap_h, 2*snap_h, l*0.6],
        slope = guide.z/2/(w/8),
        snap_top = slope * (snap.x-guide.x)/2,

        verts = [
            [-w/2,-base,-l/2], [-w/2,-base,l/2], [w/2,-base,l/2], [w/2,-base,-l/2],

            [-w/2, 0,-l/2],
            [-w/2, guide.y/2,-guide.z/2],
            [-w/2, guide.y/2, guide.z/2],
            [-w/2, 0,l/2],
            [ w/2, 0,l/2],
            [ w/2, guide.y/2, guide.z/2],
            [ w/2, guide.y/2,-guide.z/2],
            [ w/2, 0,-l/2],

            [-guide.x/2, 0,-l/2],
            [-guide.x/2,-guide.y/2,-guide.z/2],
            [-guide.x/2-w/8,-guide.y/2, 0],
            [-guide.x/2,-guide.y/2, guide.z/2],
            [-guide.x/2, 0,l/2],
            [ guide.x/2, 0,l/2],
            [ guide.x/2,-guide.y/2, guide.z/2],
            [ guide.x/2+w/8,-guide.y/2, 0],
            [ guide.x/2,-guide.y/2,-guide.z/2],
            [ guide.x/2, 0,-l/2],

            [-w/6, -snap.y/2, -snap.z/2],
            [-w/6, -snap.y/2, -guide.z/2],
            [-snap.x/2, 0, snap_top-guide.z/2],
            [-w/6,  snap.y/2, -guide.z/2],
            [-w/6,  snap.y/2, -snap.z/2],
            [-snap.x/2, 0, snap_top-snap.z/2],

            [-w/6, -snap.y/2, snap.z/2],
            [-w/6, -snap.y/2, guide.z/2],
            [-snap.x/2, 0, guide.z/2-snap_top],
            [-w/6,  snap.y/2, guide.z/2],
            [-w/6,  snap.y/2, snap.z/2],
            [-snap.x/2, 0, snap.z/2-snap_top],

            [ w/6, -snap.y/2, snap.z/2],
            [ w/6, -snap.y/2, guide.z/2],
            [ snap.x/2, 0, guide.z/2-snap_top],
            [ w/6,  snap.y/2, guide.z/2],
            [ w/6,  snap.y/2, snap.z/2],
            [ snap.x/2, 0, snap.z/2-snap_top],

            [ w/6, -snap.y/2, -snap.z/2],
            [ w/6, -snap.y/2, -guide.z/2],
            [ snap.x/2, 0, snap_top-guide.z/2],
            [ w/6,  snap.y/2, -guide.z/2],
            [ w/6,  snap.y/2, -snap.z/2],
            [ snap.x/2, 0, snap_top-snap.z/2],

            [-w/6, guide.y/2, -guide.z/2],
            [-guide.x/2-w/8, guide.y/2, 0],
            [-w/6, guide.y/2,  guide.z/2],
            [ w/6, guide.y/2,  guide.z/2],
            [ guide.x/2+w/8, guide.y/2, 0],
            [ w/6, guide.y/2, -guide.z/2],

            if (screwsize != undef) each [
                for (a = [0:45:359]) [guide.x/2+w/8, 0, 0] + screwsize * 1.1 / 2 * [-abs(sin(a))/slope, cos(a), sin(a)],
                for (a = [0:45:359]) [-(guide.x/2+w/8), 0, 0] + screwsize * 1.1 / 2 * [abs(sin(a))/slope, cos(a), sin(a)],
                for (a = [0:45:359]) [w/2, 0, 0] + screwsize * 1.1 / 2 * [0, cos(a), sin(a)],
                for (a = [0:45:359]) [-w/2, 0, 0] + screwsize * 1.1 / 2 * [0, cos(a), sin(a)],
            ]
        ],
        faces = [
            [0,1,2], [2,3,0],

            [1,7,16], [1,16,17], [1,17,8], [1,8,2],
            [0,3,11], [0,11,21], [0,21,12], [0,12,4],

            [10,51,11], [51,21,11],
            [12,46,5], [12,5,4],
            [9,8,49], [17,49,8],
            [6,16,7], [6,48,16],

            [50,10,9], [50,9,49], [50,51,10],
            [6,47,48], [6,5,47], [5,46,47],

            [24,25,26], [26,27,24],
            [22,24,27], [22,23,24],
            [22,27,26],

            [30,33,32], [30,32,31],
            [30,28,33], [30,29,28],
            [32,33,28],

            [40,42,41], [40,45,42],
            [45,43,42], [43,45,44],
            [40,44,45],

            [36,37,38], [36,38,39],
            [36,34,35], [36,39,34],
            [39,38,34],

            [12,22,26], [12,13,22], [22,13,23], [12,26,46], [46,26,25],
            [16,32,28], [16,28,15], [15,28,29], [48,32,16], [32,48,31],
            [17,34,38], [17,18,34], [18,35,34], [49,17,38], [37,49,38],
            [21,44,40], [51,44,21], [43,44,51], [20,21,40], [20,40,41],

            [17,16,18], [18,16,15],
            [21,20,13], [13,12,21],

            [20,19,18], [15,14,13], [13,20,18], [13,18,15],

            if (screwsize == undef) each [
                [0,4,5], [0,5,6], [0,6,1], [1,6,7],
                [3,10,11], [3,9,10], [2,9,3], [2,8,9],

                [19,50,36], [19,36,35], [19,35,18], [36,50,37], [49,37,50],
                [19,42,50], [19,41,42], [41,19,20], [50,42,43], [50,43,51],
                [14,47,24], [14,24,23], [14,23,13], [47,25,24], [46,25,47],
                [47,14,30], [14,29,30], [14,15,29], [47,30,31], [47,31,48],
            ] else each [
                [3,2,72], [2,71,72], [2,70,71], [2,8,70],
                [8,9,70], [9,69,70], [9,68,69], [9,10,68],
                [10,75,68], [10,74,75], [10,11,74],
                [3,72,73], [3,73,74], [3,74,11],

                [1,0,80], [0,81,80], [0,82,81], [0,4,82],
                [4,5,82], [5,83,82], [5,76,83], [5,6,76],
                [6,77,76], [6,78,77], [6,7,78],
                [7,1,78], [1,79,78], [1,80,79],

                [20,56,19], [20,57,56], [20,58,57], [20,42,58], [20,41,42],
                [50,52,51], [51,52,59], [51,59,58], [51,58,42], [51,42,43],
                [49,52,50], [49,53,52], [49,54,53], [49,36,54], [49,37,36],
                [56,18,19], [18,56,55], [18,55,54], [18,54,36], [18,36,35],
                [14,15,64], [15,63,64], [15,62,63], [15,30,62], [15,29,30],
                [48,30,31], [48,62,30], [48,61,62], [48,60,61], [60,48,47],
                [13,24,23], [13,66,24], [13,65,66], [13,64,65], [64,13,14],
                [46,60,47], [46,67,60], [46,66,67], [46,24,66], [46,25,24],

                for (i=[0:7]) let(b=52) each [
                    [b+i, b+16+(i+1)%8, b+16+i],
                    [b+i, b+(i+1)%8, b+16+(i+1)%8],
                ],
                for (i=[0:7]) let(b=60) each [
                    [b+i, b+16+i, b+16+(i+1)%8],
                    [b+i, b+16+(i+1)%8, b+(i+1)%8],
                ],
            ],
        ],
        pvnf = [verts, faces],
        vnf = xrot(90, p=pvnf)
    ) reorient(anchor,spin,orient, size=[w,l,base*2], p=vnf);

module half_joiner2(l=20, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP)
{
    vnf = half_joiner2(l=l, w=w, base=base, ang=ang, screwsize=screwsize);
    if (in_list("remove",$tags_shown)) {
        attachable(anchor,spin,orient, size=[w,l,base*2], $tags="remove") {
            half_joiner_clear(l=l, w=w, ang=ang, clearance=1);
            union();
        }
    } else {
        attachable(anchor,spin,orient, size=[w,base*2,l], $tags="keep") {
            vnf_polyhedron(vnf, convexity=12);
            children();
        }
    }
}



// Section: Full Joiners


// Module: joiner_clear()
// Description:
//   Creates a mask to clear an area so that a joiner can be placed there.
// Usage:
//   joiner_clear(l, w, [ang=], [clearance=], [overlap=]) [ATTACHMENTS];
// Topics: Joiners, Parts
// Arguments:
//   l = Length of the joiner to clear space for.
//   w = Width of the joiner to clear space for.
//   ang = Overhang angle of the joiner.
//   ---
//   clearance = Extra width to clear.
//   overlap = Extra depth to clear.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// See Also: half_joiner_clear(), half_joiner(), half_joiner2(), joiner_clear(), joiner()
// Example:
//   joiner_clear();
function joiner_clear(l=40, w=10, ang=30, clearance=0, overlap=0.01, anchor=CENTER, spin=0, orient=UP) = no_function("joiner_clear");
module joiner_clear(l=40, w=10, ang=30, clearance=0, overlap=0.01, anchor=CENTER, spin=0, orient=UP)
{
    dmnd_height = l*0.5;
    dmnd_width = dmnd_height*tan(ang);
    guide_size = w/3;
    guide_width = 2*(dmnd_height/2-guide_size)*tan(ang);

    attachable(anchor,spin,orient, size=[w, guide_width, l]) {
        union() {
            back(l/4) half_joiner_clear(l=l/2+0.01, w=w, ang=ang, overlap=overlap, clearance=clearance);
            fwd(l/4) half_joiner_clear(l=l/2+0.01, w=w, ang=ang, overlap=overlap, clearance=-0.01);
        }
        children();
    }
}



// Module: joiner()
// Usage:
//   joiner(l, w, base, [ang=], [screwsize=], [$slop=]) [ATTACHMENTS];
// Topics: Joiners, Parts
// Description:
//   Creates a joiner object that can be attached to another joiner object.
// Arguments:
//   l = Length of the joiner.
//   w = Width of the joiner.
//   base = Length of the backing to the joiner.
//   ang = Overhang angle of the joiner.
//   ---
//   screwsize = If given, diameter of screwhole.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//   $slop = Printer specific slop value to make parts fit more closely.
// See Also: half_joiner_clear(), half_joiner(), half_joiner2(), joiner_clear(), joiner()
// Examples(FlatSpin,VPD=125):
//   joiner(screwsize=3);
//   joiner(l=40, w=10, base=10);
// Example(3D):
//   diff()
//   cuboid(50)
//     attach([FWD,TOP,RIGHT])
//       zrot_copies(n=2,r=15)
//         joiner();
function joiner(l=40, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP) = no_function("joiner");
module joiner(l=40, w=10, base=10, ang=30, screwsize, anchor=CENTER, spin=0, orient=UP)
{
    if (in_list("remove",$tags_shown)) {
        attachable(anchor,spin,orient, size=[w,l,base*2], $tags="remove") {
            joiner_clear(w=w, l=l, ang=ang, clearance=1);
            union();
        }
    } else {
        attachable(anchor,spin,orient, size=[w,l,base*2], $tags="keep") {
            union() {
                back(l/4) half_joiner(l=l/2, w=w, base=base, ang=ang, screwsize=screwsize);
                fwd(l/4) half_joiner2(l=l/2, w=w, base=base, ang=ang, screwsize=screwsize);
            }
            children();
        }
    }
}



// Section: Dovetails

// Module: dovetail()
//
// Usage:
//   dovetail(gender, w=|width, h=|height, slide, [slope=|angle=], [taper=|back_width=], [chamfer=], [r=|radius=], [round=], [extra=], [$slop=])
//
// Description:
//   Produces a possibly tapered dovetail joint shape to attach to or subtract from two parts you wish to join together.
//   The tapered dovetail is particularly advantageous for long joints because the joint assembles without binding until
//   it is fully closed, and then wedges tightly.  You can chamfer or round the corners of the dovetail shape for better
//   printing and assembly, or choose a fully rounded joint that looks more like a puzzle piece.  The dovetail appears 
//   parallel to the Y axis and projecting upwards, so in its default orientation it will slide together with a translation
//   in the positive Y direction.  The gender determines whether the shape is meant to be added to your model or
//   differenced, and it also changes the anchor and orientation.  The default anchor for dovetails is BOTTOM;
//   the default orientation depends on the gender, with male dovetails oriented UP and female ones DOWN.  The dovetails by default
//   have extra extension of 0.01 for unions and differences.  You should ensure that attachment is done with overlap=0 to ensure that
//   the sizing and positioning is correct.
//
// Arguments:
//   gender = A string, "male" or "female", to specify the gender of the dovetail.
//   w / width = Width (at the wider, top end) of the dovetail before tapering
//   h / height = Height of the dovetail (the amount it projects from its base)
//   slide = Distance the dovetail slides when you assemble it (length of sliding dovetails, thickness of regular dovetails)
//   ---
//   slope = slope of the dovetail.  Standard woodworking slopes are 4, 6, or 8.  Default: 6.  
//   angle = angle (in degrees) of the dovetail.  Specify only one of slope and angle.
//   taper = taper angle (in degrees). Dovetail gets narrower by this angle.  Default: no taper
//   back_width = width of right hand end of the dovetail.  This alternate method of specifying the taper may be easier to manage.  Specify only one of `taper` and `back_width`.  Note that `back_width` should be smaller than `width` to taper in the customary direction, with the smaller end at the back.  
//   chamfer = amount to chamfer the corners of the joint (Default: no chamfer)
//   r / radius = amount to round over the corners of the joint (Default: no rounding)
//   round = true to round both corners of the dovetail and give it a puzzle piece look.  Default: false.  
//   extra = amount of extra length and base extension added to dovetails for unions and differences.  Default: 0.01
// Example: Ordinary straight dovetail, male version (sticking up) and female version (below the xy plane)
//   dovetail("male", width=15, height=8, slide=30);
//   right(20) dovetail("female", width=15, height=8, slide=30);
// Example: Adding a 6 degree taper (Such a big taper is usually not necessary, but easier to see for the example.)
//   dovetail("male", w=15, h=8, slide=30, taper=6);
//   right(20) dovetail("female", 15, 8, 30, taper=6);  // Same as above
// Example: A block that can link to itself
//   diff("remove")
//     cuboid([50,30,10]){
//       attach(BACK) dovetail("male", slide=10, width=15, height=8);
//       attach(FRONT) dovetail("female", slide=10, width=15, height=8,$tags="remove");
//     }
// Example: Setting the dovetail angle.  This is too extreme to be useful.  
//   diff("remove")
//     cuboid([50,30,10]){
//       attach(BACK) dovetail("male", slide=10, width=15, height=8, angle=30);
//       attach(FRONT) dovetail("female", slide=10, width=15, height=8, angle=30,$tags="remove");
//     }
// Example: Adding a chamfer helps printed parts fit together without problems at the corners
//   diff("remove")
//     cuboid([50,30,10]){
//       attach(BACK) dovetail("male", slide=10, width=15, height=8, chamfer=1);
//       attach(FRONT) dovetail("female", slide=10, width=15, height=8,chamfer=1,$tags="remove");
//     }
// Example: Rounding the outside corners is another option
//   diff("remove")
//   cuboid([50,30,10]) {
//       attach(BACK)  dovetail("male", slide=10, width=15, height=8, radius=1, $fn=32);
//       attach(FRONT) dovetail("female", slide=10, width=15, height=8, radius=1, $tags="remove", $fn=32);
//   }
// Example: Or you can make a fully rounded joint
//   $fn=32;
//   diff("remove")
//   cuboid([50,30,10]){
//       attach(BACK) dovetail("male", slide=10, width=15, height=8, radius=1.5, round=true);
//       attach(FRONT) dovetail("female", slide=10, width=15, height=8, radius=1.5, round=true, $tags="remove");
//   }
// Example: With a long joint like this, a taper makes the joint easy to assemble.  It will go together easily and wedge tightly if you get the tolerances right.  Specifying the taper with `back_width` may be easier than using a taper angle.    
//   cuboid([50,30,10])
//     attach(TOP) dovetail("male", slide=50, width=18, height=4, back_width=15, spin=90);
//   fwd(35)
//     diff("remove")
//       cuboid([50,30,10])
//         attach(TOP) dovetail("female", slide=50, width=18, height=4, back_width=15, spin=90, $tags="remove");
// Example: A series of dovetails forming a tail board, with the inside of the joint up.  A standard wood joint would have a zero taper. 
//   cuboid([50,30,10])
//     attach(BACK) xcopies(10,5) dovetail("male", slide=10, width=7, taper=4, height=4);
// Example: Mating pin board for a half-blind right angle joint, where the joint only shows on the side but not the front.  Note that the anchor method and use of `spin` ensures that the joint works even with a taper.
//   diff("remove")
//     cuboid([50,30,10])
//       position(TOP+BACK) xcopies(10,5) dovetail("female", slide=10, width=7, taper=4, height=4, $tags="remove",anchor=BOTTOM+FRONT,spin=180);
function dovetail(gender, width, height, slide, h, w, angle, slope, taper, back_width, chamfer, extra=0.01, r, radius, round=false, anchor=BOTTOM, spin=0, orient) = no_function("dovetail");
module dovetail(gender, width, height, slide, h, w, angle, slope, taper, back_width, chamfer, extra=0.01, r, radius, round=false, anchor=BOTTOM, spin=0, orient)
{
    radius = get_radius(r1=radius,r2=r);
    hcount = num_defined([h,height]);
    wcount = num_defined([w,width]);
    assert(is_def(slide), "Must define slide");
    assert(hcount==1, "Must define exactly one of h and height");
    assert(wcount==1, "Must define exactly one of w and width");
    h = first_defined([h,height]);
    w = first_defined([w,width]);
    orient = is_def(orient) ? orient :
        gender == "female" ? DOWN : UP;
    count = num_defined([angle,slope]);
    assert(count<=1, "Do not specify both angle and slope");
    count2 = num_defined([taper,back_width]);
    assert(count2<=1, "Do not specify both taper and back_width");
    count3 = num_defined([chamfer, radius]);
    assert(count3<=1 || (radius==0 && chamfer==0), "Do not specify both chamfer and radius");
    slope = is_def(slope) ? slope :
        is_def(angle) ? 1/tan(angle) :  6;
    extra_slop = gender == "female" ? 2*get_slop() : 0;
    width = w + extra_slop;
    height = h + extra_slop;
    back_width = u_add(back_width, extra_slop);

    front_offset = is_def(taper) ? -extra * tan(taper) :
        is_def(back_width) ? extra * (back_width-width)/slide/2 : 0;

    size = is_def(chamfer) && chamfer>0 ? chamfer :
        is_def(radius) && radius>0 ? radius : 0;
    type = is_def(chamfer) && chamfer>0 ? "chamfer" : "circle";

    fullsize = round ? [size,size] :
        gender == "male" ? [size,0] : [0,size];

    smallend_half = round_corners(
        move(
            [0,-slide/2-extra,0],
            p=[
                [0                     , 0, height],
                [width/2-front_offset  , 0, height],
                [width/2 - height/slope - front_offset, 0, 0 ],
                [width/2 - front_offset + height, 0, 0]
            ]
        ),
        method=type, cut = fullsize, closed=false
    );
    smallend_points = concat(select(smallend_half, 1, -2), [down(extra,p=select(smallend_half, -2))]);
    offset = is_def(taper) ? -(slide+extra) * tan(taper) :
        is_def(back_width) ? (back_width-width) / 2 : 0;
    bigend_points = move([offset,slide+2*extra,0], p=smallend_points);

    //adjustment = $overlap * (gender == "male" ? -1 : 1);  // Adjustment for default overlap in attach()
    adjustment = 0;    // Default overlap is assumed to be zero
    
    attachable(anchor,spin,orient, size=[width+2*offset, slide, height]) {
        down(height/2+adjustment) {
            skin(
                [
                    reverse(concat(smallend_points, xflip(p=reverse(smallend_points)))),
                    reverse(concat(bigend_points, xflip(p=reverse(bigend_points))))
                ],
                slices=0, convexity=4
            );
        }
        children();
    }
}


// Section: Tension Clips

// h is total height above 0 of the nub
// nub extends below xy plane by distance nub/2
module _pin_nub(r, nub, h)
{
    L = h / 4;
    rotate_extrude(){
      polygon(
       [[ 0,-nub/2],
        [-r,-nub/2],
        [-r-nub, nub/2],
        [-r-nub, nub/2+L],
        [-r, h],
        [0, h]]);
     }  
}


module _pin_slot(l, r, t, d, nub, depth, stretch) {
  yscale(4)
    intersection() {
      translate([t, 0, d + t / 4])
          _pin_nub(r = r + t, nub = nub, h = l - (d + t / 4));
      translate([-t, 0, d + t / 4]) 
          _pin_nub(r = r + t, nub = nub, h = l - (d + t / 4));
    }
  cube([2 * r, depth, 2 * l], center = true);
  up(l)
    zscale(stretch)
      ycyl(r = r, h = depth);
}


module _pin_shaft(r, lStraight, nub, nubscale, stretch, d, pointed)
{
   extra = 0.02;         // This sets the extra extension below the socket bottom
                         // so that difference() works without issues
   rPoint = r / sqrt(2);
   down(extra) cylinder(r = r, h = lStraight + extra);
   up(lStraight) {
      zscale(stretch) {
         sphere(r = r);
         if (pointed) up(rPoint) cylinder(r1 = rPoint, r2 = 0, h = rPoint);
      }
   }
   up(d) yscale(nubscale) _pin_nub(r = r, nub = nub, h = lStraight - d);
}

function _pin_size(size) =
  is_undef(size) ? [] :
  let(sizeok = in_list(size,["tiny", "small","medium", "large", "standard"]))
  assert(sizeok,"Pin size must be one of \"tiny\", \"small\", or \"standard\"")
  size=="standard" || size=="large" ?
     struct_set([], ["length", 10.8,
                     "diameter", 7,
                     "snap", 0.5,
                     "nub_depth", 1.8,
                     "thickness", 1.8,
                     "preload", 0.2]):
  size=="medium" ?
     struct_set([], ["length", 8,
                     "diameter", 4.6,
                     "snap", 0.45,
                     "nub_depth", 1.5,
                     "thickness", 1.4,
                     "preload", 0.2]) :
  size=="small" ? 
     struct_set([], ["length", 6, 
                     "diameter", 3.2,
                     "snap", 0.4,
                     "nub_depth", 1.2,
                     "thickness", 1.0,
                     "preload", 0.16]) :
  size=="tiny" ? 
     struct_set([], ["length", 4, 
                     "diameter", 2.5,
                     "snap", 0.25,
                     "nub_depth", 0.9,
                     "thickness", 0.8,
                     "preload", 0.1]):
  undef;


// Module: snap_pin()
// Usage:
//    snap_pin(size, [pointed=], [anchor=], [spin=], [orient]=) [ATTACHMENTS];
//    snap_pin(r=|radius=|d=|diameter=, l=|length=, nub_depth=, snap=, thickness=, [clearance=], [preload=], [pointed=]) [ATTACHMENTS];
// Description:
//    Creates a snap pin that can be inserted into an appropriate socket to connect two objects together.  You can choose from some standard
//    pin dimensions by giving a size, or you can specify all the pin geometry parameters yourself.  If you use a standard size you can
//    override the standard parameters by specifying other ones.  The pins have flat sides so they can
//    be printed.  When oriented UP the shaft of the pin runs in the Z direction and the flat sides are the front and back.  The default
//    orientation (FRONT) and anchor (FRONT) places the pin in a printable configuration, flat side down on the xy plane.
//    The tightness of fit is determined by `preload` and `clearance`.  To make pins tighter increase `preload` and/or decrease `clearance`.  
//    .
//    The "large" or "standard" size pin has a length of 10.8 and diameter of 7.  The "medium" pin has a length of 8 and diameter of 4.6.  The "small" pin
//    has a length of 6 and diameter of 3.2.  The "tiny" pin has a length of 4 and a diameter of 2.5.  
//    .
//    This pin is based on https://www.thingiverse.com/thing:213310 by Emmett Lalishe
//    and a modified version at https://www.thingiverse.com/thing:3218332 by acwest
//    and distributed under the Creative Commons - Attribution - Share Alike License
// Arguments:
//    size = text string to select from a list of predefined sizes, one of "standard", "small", or "tiny".
//    ---
//    pointed = set to true to get a pointed pin, false to get one with a rounded end.  Default: true
//    r/radius = radius of the pin
//    d/diameter = diameter of the pin
//    l/length = length of the pin
//    nub_depth = the distance of the nub from the base of the pin
//    snap = how much snap the pin provides (the nub projection)
//    thickness = thickness of the pin walls
//    pointed = if true the pin is pointed, otherwise it has a rounded tip.  Default: true
//    clearance = how far to shrink the pin away from the socket walls.  Default: 0.2
//    preload = amount to move the nub towards the pin base, which can create tension from the misalignment with the socket.  Default: 0.2
// Example: Pin in native orientation
//    snap_pin("standard", anchor=CENTER, orient=UP, thickness = 1, $fn=40);
// Example: Pins oriented for printing
//    xcopies(spacing=10, n=4) snap_pin("standard", $fn=40);
function snap_pin(size,r,radius,d,diameter, l,length, nub_depth, snap, thickness, clearance=0.2, preload, pointed=true, anchor=FRONT, spin=0, orient=FRONT, center) =no_function("snap_pin");
module snap_pin(size,r,radius,d,diameter, l,length, nub_depth, snap, thickness, clearance=0.2, preload, pointed=true, anchor=FRONT, spin=0, orient=FRONT, center) {
  preload_default = 0.2;
  sizedat = _pin_size(size);
  radius = get_radius(r1=r,r2=radius,d1=d,d2=diameter,dflt=struct_val(sizedat,"diameter")/2);
  length = first_defined([l,length,struct_val(sizedat,"length")]);
  snap = first_defined([snap, struct_val(sizedat,"snap")]);
  thickness = first_defined([thickness, struct_val(sizedat,"thickness")]);
  nub_depth = first_defined([nub_depth, struct_val(sizedat,"nub_depth")]);
  preload = first_defined([first_defined([preload, struct_val(sizedat, "preload")]),preload_default]);

  nubscale = 0.9;      // Mysterious arbitrary parameter

  // The basic pin assumes a rounded cap of length sqrt(2)*r, which defines lStraight.
  // If the point is enabled the cap length is instead 2*r
  // preload shrinks the length, bringing the nubs closer together  

  rInner = radius - clearance;
  stretch = sqrt(2)*radius/rInner;  // extra stretch factor to make cap have proper length even though r is reduced.
  lStraight = length - sqrt(2) * radius - clearance;
  lPin = lStraight + (pointed ? 2*radius : sqrt(2)*radius);
  attachable(anchor=anchor,spin=spin, orient=orient,
             size=[nubscale*(2*rInner+2*snap + clearance),radius*sqrt(2)-2*clearance,2*lPin]){
  zflip_copy()
      difference() {
        intersection() {
            cube([3 * (radius + snap), radius * sqrt(2) - 2 * clearance, 2 * length + 3 * radius], center = true);
            _pin_shaft(rInner, lStraight, snap+clearance/2, nubscale, stretch, nub_depth-preload, pointed);
        }
        _pin_slot(l = lStraight, r = rInner - thickness, t = thickness, d = nub_depth - preload, nub = snap, depth = 2 * radius + 0.02, stretch = stretch);
      }
  children();
  }
}

// Module: snap_pin_socket()
// Usage:
//   snap_pin_socket(size, [fixed=], [fins=], [pointed=], [anchor=], [spin=], [orient=]) [ATTACHMENTS];
//   snap_pin_socket(r=|radius=|d=|diameter=, l=|length=, nub_depth=, snap=, [fixed=], [pointed=], [fins=]) [ATTACHMENTS];
// Description:
//   Constructs a socket suitable for a snap_pin with the same parameters.   If `fixed` is true then the socket has flat walls and the
//   pin will not rotate in the socket.  If `fixed` is false then the socket is round and the pin will rotate, particularly well
//   if you add a lubricant.  If `pointed` is true the socket is pointed to receive a pointed pin, otherwise it has a rounded and and
//   will be shorter.  If `fins` is set to true then two fins are included inside the socket to act as supports (which may help when printing tip up,
//   especially when `pointed=false`).  The default orientation is DOWN with anchor BOTTOM so that you can difference() the socket away from an object.
//   The socket extends 0.02 extra below its bottom anchor point so that differences will work correctly.  (You must have $overlap smaller than 0.02 in 
//   attach or the socket will be beneath the surface of the parent object.)  
//   .
//   The "large" or "standard" size pin has a length of 10.8 and diameter of 7.  The "medium" pin has a length of 8 and diameter of 4.6.  The "small" pin
//   has a length of 6 and diameter of 3.2.  The "tiny" pin has a length of 4 and a diameter of 2.5.  
// Arguments:
//   size = text string to select from a list of predefined sizes, one of "standard", "small", or "tiny".
//   ---
//   pointed = set to true to get a pointed pin, false to get one with a rounded end.  Default: true
//   r/radius = radius of the pin
//   d/diameter = diameter of the pin
//   l/length = length of the pin
//   nub_depth = the distance of the nub from the base of the pin
//   snap = how much snap the pin provides (the nub projection)
//   fixed = if true the pin cannot rotate, if false it can.  Default: true
//   pointed = if true the socket has a pointed tip.  Default: true
//   fins = if true supporting fins are included.  Default: false
// Example:  The socket shape itself in native orientation.
//   snap_pin_socket("standard", anchor=CENTER, orient=UP, fins=true, $fn=40);
// Example:  A spinning socket with fins:
//   snap_pin_socket("standard", anchor=CENTER, orient=UP, fins=true, fixed=false, $fn=40);
// Example:  A cube with a socket in the middle and one half-way off the front edge so you can see inside:
//   $fn=40;
//   diff("socket") cuboid([20,20,20]) {
//     attach(TOP) snap_pin_socket("standard", $tags="socket");
//     position(TOP+FRONT)snap_pin_socket("standard", $tags="socket");
//   }
function snap_pin_socket(size, r, radius, l,length, d,diameter,nub_depth, snap, fixed=true, pointed=true, fins=false, anchor=BOTTOM, spin=0, orient=DOWN) = no_function("snap_pin_socket");
module snap_pin_socket(size, r, radius, l,length, d,diameter,nub_depth, snap, fixed=true, pointed=true, fins=false, anchor=BOTTOM, spin=0, orient=DOWN) {
  sizedat = _pin_size(size);
  radius = get_radius(r1=r,r2=radius,d1=d,d2=diameter,dflt=struct_val(sizedat,"diameter")/2);
  length = first_defined([l,length,struct_val(sizedat,"length")]);
  snap = first_defined([snap, struct_val(sizedat,"snap")]);
  nub_depth = first_defined([nub_depth, struct_val(sizedat,"nub_depth")]);

  tip = pointed ? sqrt(2) * radius : radius;
  lPin = length + (pointed?(2-sqrt(2))*radius:0);
  lStraight = lPin - (pointed?sqrt(2)*radius:radius);
  attachable(anchor=anchor,spin=spin,orient=orient,
             size=[2*(radius+snap),radius*sqrt(2),lPin])
  {  
  down(lPin/2)
    intersection() {
      cube([3 * (radius + snap), fixed ? radius * sqrt(2) : 3*(radius+snap), 3 * lPin + 3 * radius], center = true);        
      union() {
        _pin_shaft(radius,lStraight,snap,1,1,nub_depth,pointed);
        if (fins) 
          up(lStraight){
            cube([2 * radius, 0.01, 2 * tip], center = true);
            cube([0.01, 2 * radius, 2 * tip], center = true);
          }
      }
    }
  children();
  } 
}



// Module: rabbit_clip()
// Usage:
//   rabbit_clip(type, length, width, snap, thickness, depth, [compression=], [clearance=], [lock=], [lock_clearance=], [splineteps=], [anchor=], [orient=], [spin=]) [ATTACHMENTS];
// Description:
//   Creates a clip with two flexible ears to lock into a mating socket, or create a mask to produce the appropriate
//   mating socket.  The clip can be made to insert and release easily, or to hold much better, or it can be
//   created with locking flanges that will make it very hard or impossible to remove.  Unlike the snap pin, this clip
//   is rectangular and can be made at any height, so a suitable clip could be very thin.  It's also possible to get a
//   solid connection with a short pin.
//   .
//   The type parameters specifies whether to make a clip, a socket mask, or a double clip.  The length is the
//   total nominal length of the clip.  (The actual length will be very close, but not equal to this.)  The width
//   gives the nominal width of the clip, which is the actual width of the clip at its base.  The snap parameter
//   gives the depth of the clip sides, which controls how easy the clip is to insert and remove.  The clip "ears" are
//   made over-wide by the compression value.  A nonzero compression helps make the clip secure in its socket.
//   The socket's width and length are increased by the clearance value which creates some space and can compensate
//   for printing inaccuracy.  The socket will be slightly longer than the nominal width.  The thickness is the thickness
//   curved line that forms the clip.  The clip depth is the amount the basic clip shape is extruded.  Be sure that you
//   make the socket with a larger depth than the clip (try 0.4 mm) to allow ease of insertion of the clip.  The clearance
//   value does not apply to the depth.  The splinesteps parameter increases the sampling of the clip curves.
//   .
//   By default clips appear with orient=UP and sockets with orient=DOWN.  The clips and sockets extend 0.02 units below
//   their base so that unions and differences will work without trouble, but be sure that the attach overlap is smaller
//   than 0.02.  
//   .
//   The first figure shows the dimensions of the rabbit clip.  The second figure shows the clip in red overlayed on
//   its socket in yellow.  The left clip has a nonzero clearance, so its socket is bigger than the clip all around.
//   The right hand locking clip has no clearance, but it has a lock clearance, which provides some space behind
//   the lock to allow the clip to fit.  (Note that depending on your printer, this can be set to zero.)
// Figure(2DMed):
//   snap=1.5;
//   comp=0.75;
//   mid = 8.053;  // computed in rabbit_clip
//   tip = [-4.58,18.03];
//   translate([9,3]){
//   back_half()
//      rabbit_clip("pin",width=12, length=18, depth=1, thickness = 1, compression=comp, snap=snap, orient=BACK);
//   color("blue"){
//      stroke([[6,0],[6,18]],width=0.1);
//      stroke([[6+comp, 12], [6+comp, 18]], width=.1);
//   }
//   color("red"){
//      stroke([[6-snap,mid], [6,mid]], endcaps="arrow2",width=0.15);
//      translate([6+.4,mid-.15])text("snap",size=1,valign="center");
//      translate([6+comp/2,19.5])text("compression", size=1, halign="center");
//      stroke([[6+comp/2,19.3], [6+comp/2,17.7]], endcap2="arrow2", width=.15);
//      fwd(1.1)text("width",size=1,halign="center");
//      xflip_copy()stroke([[2,-.7], [6,-.7]], endcap2="arrow2", width=.15);     
//      move([-6.7,mid])rot(90)text("length", size=1, halign="center");
//      stroke([[-7,10.3], [-7,18]], width=.15, endcap2="arrow2");
//      stroke([[-7,0], [-7,5.8]], width=.15,endcap1="arrow2");
//      stroke([tip, tip-[0,1]], width=.15);
//      move([tip.x+2,19.5])text("thickness", halign="center",size=1);
//      stroke([[tip.x+2, 19.3], tip+[.1,.1]], width=.15, endcap2="arrow2");
//   }
//   }
//
// Figure(2DMed):
//   snap=1.5;
//   comp=0;
//   translate([29,3]){
//   back_half()
//      rabbit_clip("socket", width=12, length=18, depth=1, thickness = 1, compression=comp, snap=snap, orient=BACK,lock=true);
//   color("red")back_half()
//      rabbit_clip("pin",width=12, length=18, depth=1, thickness = 1, compression=comp, snap=snap,
//               orient=BACK,lock=true,lock_clearance=1);
//   }
//   translate([9,3]){
//   back_half()
//      rabbit_clip("socket", clearance=.5,width=12, length=18, depth=1, thickness = 1,
//                  compression=comp, snap=snap, orient=BACK,lock=false);
//   color("red")back_half()
//      rabbit_clip("pin",width=12, length=18, depth=1, thickness = 1, compression=comp, snap=snap,
//               orient=BACK,lock=false,lock_clearance=1);
//   }
// Arguments:
//   type = One of "pin",  "socket", "male", "female" or "double" to specify what to make.
//   length = nominal clip length
//   width = nominal clip width
//   snap = depth of hollow on the side of the clip
//   thickness = thickness of the clip "line"
//   depth = amount to extrude clip (give extra room for the socket, about 0.4mm)
//   ---
//   compression = excess width at the "ears" to lock more tightly.  Default: 0.1
//   clearance = extra space in the socket for easier insertion.  Default: 0.1
//   lock = set to true to make a locking clip that may be irreversible.  Default: false
//   lock_clearance = give clearance for the lock.  Default: 0
//   splinesteps = number of samples in the curves of the clip.  Default: 8
//   anchor = anchor point for clip
//   orient = clip orientation.  Default: UP for pins, DOWN for sockets
//   spin = spin the clip.  Default: 0
//
// Example:  Here are several sizes that work printed in PLA on a Prusa MK3, with default clearance of 0.1 and a depth of 5
//   module test_pair(length, width, snap, thickness, compression, lock=false)
//   {
//     depth = 5;
//     extra_depth = 10;// Change this to 0.4 for closed sockets
//     cuboid([max(width+5,12),12, depth], chamfer=.5, edges=[FRONT,"Y"], anchor=BOTTOM)
//         attach(BACK)
//           rabbit_clip(type="pin",length=length, width=width,snap=snap,thickness=thickness,depth=depth,
//                       compression=compression,lock=lock);
//     right(width+13)
//     diff("remove")
//         cuboid([width+8,max(12,length+2),depth+3], chamfer=.5, edges=[FRONT,"Y"], anchor=BOTTOM)
//             attach(BACK)
//               rabbit_clip(type="socket",length=length, width=width,snap=snap,thickness=thickness,depth=depth+extra_depth,
//                           lock=lock,compression=0,$tags="remove");
//   }
//   left(37)ydistribute(spacing=28){
//     test_pair(length=6, width=7, snap=0.25, thickness=0.8, compression=0.1);
//     test_pair(length=3.5, width=7, snap=0.1, thickness=0.8, compression=0.1);  // snap = 0.2 gives a firmer connection
//     test_pair(length=3.5, width=5, snap=0.1, thickness=0.8, compression=0.1);  // hard to take apart
//   }
//   right(17)ydistribute(spacing=28){
//     test_pair(length=12, width=10, snap=1, thickness=1.2, compression=0.2);
//     test_pair(length=8, width=7, snap=0.75, thickness=0.8, compression=0.2, lock=true); // With lock, very firm and irreversible
//     test_pair(length=8, width=7, snap=0.75, thickness=0.8, compression=0.2, lock=true); // With lock, very firm and irreversible
//   }
// Example: Double clip to connect two sockets
//   rabbit_clip("double",length=8, width=7, snap=0.75, thickness=0.8, compression=0.2,depth=5);
// Example:  A modified version of the clip that acts like a backpack strap clip, where it locks tightly but you can squeeze to release. 
//   cuboid([25,15,5],anchor=BOTTOM)
//       attach(BACK)rabbit_clip("pin", length=25, width=25, thickness=1.5, snap=2, compression=0, lock=true, depth=5, lock_clearance=3);
//   left(32)
//   diff("remove")
//   cuboid([30,30,11],orient=BACK,anchor=BACK){
//       attach(BACK)rabbit_clip("socket", length=25, width=25, thickness=1.5, snap=2, compression=0, lock=true, depth=5.5, lock_clearance=3,$tags="remove");
//       xflip_copy()
//         position(FRONT+LEFT)
//         xscale(0.8)
//         zcyl(l=20,r=13.5, $tags="remove",$fn=64);
//   }

function rabbit_clip(type, length, width,  snap, thickness, depth, compression=0.1,  clearance=.1, lock=false, lock_clearance=0,
                   splinesteps=8, anchor, orient, spin=0) = no_function("rabbit_clip");

module rabbit_clip(type, length, width,  snap, thickness, depth, compression=0.1,  clearance=.1, lock=false, lock_clearance=0,
                   splinesteps=8, anchor, orient, spin=0)
{
  assert(is_num(width) && width>0,"Width must be a positive value");
  assert(is_num(length) && length>0, "Length must be a positive value");
  assert(is_num(thickness) && thickness>0, "Thickness must be a positive value");  
  assert(is_num(snap) && snap>=0, "Snap must be a non-negative value");
  assert(is_num(depth) && depth>0, "Depth must be a positive value");
  assert(is_num(compression) && compression >= 0, "Compression must be a nonnegative value");
  assert(is_bool(lock));
  assert(is_num(lock_clearance));
  legal_types = ["pin","socket","male","female","double"];
  assert(in_list(type,legal_types),str("type must be one of ",legal_types));
  
  if (type=="double") {
    attachable(size=[width+2*compression, depth, 2*length], anchor=default(anchor,BACK), spin=spin, orient=default(orient,BACK)){
      union(){
        rabbit_clip("pin", length=length, width=width, snap=snap, thickness=thickness, depth=depth, compression=compression,
                    lock=lock, anchor=BOTTOM, orient=UP);
        rabbit_clip("pin", length=length, width=width, snap=snap, thickness=thickness, depth=depth, compression=compression,
                    lock=lock, anchor=BOTTOM, orient=DOWN);
        cuboid([width-thickness, depth, thickness]);
      }
      children();
    }
  } else {
    anchor = default(anchor,BOTTOM);
    is_pin = in_list(type,["pin","male"]);
    //default_overlap = 0.01 * (is_pin?1:-1);    // Shift by this much to undo default overlap
    default_overlap = 0;
    extra = 0.02;  // Amount of extension below nominal based position for the socket, must exceed default overlap of 0.01
    clearance = is_pin ? 0 : clearance;
    compression = is_pin ? compression : 0;
    orient =  is_def(orient) ? orient
            : is_pin ? UP
            : DOWN;
    earwidth = 2*thickness+snap;
    point_length = earwidth/2.15;
    // The adjustment is using cos(theta)*earwidth/2 and sin(theta)*point_length, but the computation
    // is obscured because theta is atan(length/2/snap)
    scaled_len = length - 0.5 * (earwidth * snap + point_length * length) / sqrt(sqr(snap)+sqr(length/2));
    bottom_pt = [0,max(scaled_len*0.15+thickness, 2*thickness)];
    ctr = [width/2,scaled_len] + line_normal([width/2-snap, scaled_len/2], [width/2, scaled_len]) * earwidth/2;
    inside_pt = circle_circle_tangents(0, bottom_pt, earwidth/2, ctr)[0][1];
    sidepath =[
               [width/2,0],
               [width/2-snap,scaled_len/2],
               [width/2+(is_pin?compression:0), scaled_len],
               ctr - point_length * line_normal([width/2,scaled_len], inside_pt),
               inside_pt
              ];
    fullpath = concat(
                      sidepath,
                      [bottom_pt], 
                      reverse(apply(xflip(),sidepath))
                      );
    assert(fullpath[4].y < fullpath[3].y, "Pin is too wide for its length");
    
    snapmargin = -snap + last(sidepath).x;// - compression;
    if (is_pin){
      if (snapmargin<0) echo("WARNING: The snap is too large for the clip to squeeze to fit its socket")
      echo(snapmargin=snapmargin);
    }
    // Force tangent to be vertical at the outer edge of the clip to avoid overshoot
    fulltangent = list_set(path_tangents(fullpath, uniform=false),[2,8], [[0,1],[0,-1]]);

    subset = is_pin ? [0:10] : [0,1,2,3, 7,8,9,10];  // Remove internal points from the socket
    tangent = select(fulltangent, subset);
    path = select(fullpath, subset);
    
    socket_smooth = .04;
    pin_smooth = [.075, .075, .15, .12, .06];
    smoothing = is_pin
                  ? concat(pin_smooth, reverse(pin_smooth))
                  : let(side_smooth=select(pin_smooth, 0, 2))
                    concat(side_smooth, [socket_smooth], reverse(side_smooth));
    bez = path_to_bezpath(path,relsize=smoothing,tangents=tangent);
    rounded = bezpath_curve(bez,splinesteps=splinesteps);
    bounds = pointlist_bounds(rounded);
    extrapt = is_pin ? [] : [rounded[0] - [0,extra]];
    finalpath = is_pin ? rounded
                       : let(withclearance=offset(rounded, r=-clearance))
                         concat( [[withclearance[0].x,-extra]],
                                 withclearance,
                                 [[-withclearance[0].x,-extra]]);
    attachable(size=[bounds[1].x-bounds[0].x, depth, bounds[1].y-bounds[0].y], anchor=anchor, spin=spin, orient=orient){
      xrot(90)
        translate([0,-(bounds[1].y-bounds[0].y)/2+default_overlap,-depth/2])
        linear_extrude(height=depth, convexity=10) {
            if (lock)
              xflip_copy()
              right(clearance)
              polygon([sidepath[1]+[-thickness/10,lock_clearance],
                       sidepath[2]-[thickness*.75,0],
                       sidepath[2],
                       [sidepath[2].x,sidepath[1].y+lock_clearance]]);
            if (is_pin)
              offset_stroke(finalpath, width=[thickness,0]);
            else
              polygon(finalpath);
        }
      children();
    }
  }
}



// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
