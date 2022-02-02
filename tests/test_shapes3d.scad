include <../std.scad>


module test_cube() {
    assert_equal(cube(100,center=true), [[[-50,-50,-50],[50,-50,-50],[50,50,-50],[-50,50,-50],[-50,-50,50],[50,-50,50],[50,50,50],[-50,50,50]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100],center=true), [[[-30,-40,-50],[30,-40,-50],[30,40,-50],[-30,40,-50],[-30,-40,50],[30,-40,50],[30,40,50],[-30,40,50]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100],anchor=CENTER), [[[-30,-40,-50],[30,-40,-50],[30,40,-50],[-30,40,-50],[-30,-40,50],[30,-40,50],[30,40,50],[-30,40,50]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100],center=false), [[[0,0,0],[60,0,0],[60,80,0],[0,80,0],[0,0,100],[60,0,100],[60,80,100],[0,80,100]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100]), [[[0,0,0],[60,0,0],[60,80,0],[0,80,0],[0,0,100],[60,0,100],[60,80,100],[0,80,100]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100],anchor=-[1,1,1]), [[[0,0,0],[60,0,0],[60,80,0],[0,80,0],[0,0,100],[60,0,100],[60,80,100],[0,80,100]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
    assert_equal(cube([60,80,100],anchor=TOP), [[[-30,-40,-100],[30,-40,-100],[30,40,-100],[-30,40,-100],[-30,-40,0],[30,-40,0],[30,40,0],[-30,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[6,4,7],[6,5,4]]]);
}
test_cube();


module test_cylinder() {
    $fn=12;
    assert_approx(cylinder(r=40,h=100,center=true), [[[40,0,-50],[34.6410161514,-20,-50],[20,-34.6410161514,-50],[0,-40,-50],[-20,-34.6410161514,-50],[-34.6410161514,-20,-50],[-40,0,-50],[-34.6410161514,20,-50],[-20,34.6410161514,-50],[0,40,-50],[20,34.6410161514,-50],[34.6410161514,20,-50],[40,0,50],[34.6410161514,-20,50],[20,-34.6410161514,50],[0,-40,50],[-20,-34.6410161514,50],[-34.6410161514,-20,50],[-40,0,50],[-34.6410161514,20,50],[-20,34.6410161514,50],[0,40,50],[20,34.6410161514,50],[34.6410161514,20,50]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
    assert_approx(cylinder(d=80,h=100,center=true), [[[40,0,-50],[34.6410161514,-20,-50],[20,-34.6410161514,-50],[0,-40,-50],[-20,-34.6410161514,-50],[-34.6410161514,-20,-50],[-40,0,-50],[-34.6410161514,20,-50],[-20,34.6410161514,-50],[0,40,-50],[20,34.6410161514,-50],[34.6410161514,20,-50],[40,0,50],[34.6410161514,-20,50],[20,-34.6410161514,50],[0,-40,50],[-20,-34.6410161514,50],[-34.6410161514,-20,50],[-40,0,50],[-34.6410161514,20,50],[-20,34.6410161514,50],[0,40,50],[20,34.6410161514,50],[34.6410161514,20,50]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
    assert_approx(cylinder(d=80,h=100,anchor=CENTER), [[[40,0,-50],[34.6410161514,-20,-50],[20,-34.6410161514,-50],[0,-40,-50],[-20,-34.6410161514,-50],[-34.6410161514,-20,-50],[-40,0,-50],[-34.6410161514,20,-50],[-20,34.6410161514,-50],[0,40,-50],[20,34.6410161514,-50],[34.6410161514,20,-50],[40,0,50],[34.6410161514,-20,50],[20,-34.6410161514,50],[0,-40,50],[-20,-34.6410161514,50],[-34.6410161514,-20,50],[-40,0,50],[-34.6410161514,20,50],[-20,34.6410161514,50],[0,40,50],[20,34.6410161514,50],[34.6410161514,20,50]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
    assert_approx(cylinder(d=80,h=100,center=false), [[[40,0,0],[34.6410161514,-20,0],[20,-34.6410161514,0],[0,-40,0],[-20,-34.6410161514,0],[-34.6410161514,-20,0],[-40,0,0],[-34.6410161514,20,0],[-20,34.6410161514,0],[0,40,0],[20,34.6410161514,0],[34.6410161514,20,0],[40,0,100],[34.6410161514,-20,100],[20,-34.6410161514,100],[0,-40,100],[-20,-34.6410161514,100],[-34.6410161514,-20,100],[-40,0,100],[-34.6410161514,20,100],[-20,34.6410161514,100],[0,40,100],[20,34.6410161514,100],[34.6410161514,20,100]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
    assert_approx(cylinder(d=80,h=100,anchor=BOT), [[[40,0,0],[34.6410161514,-20,0],[20,-34.6410161514,0],[0,-40,0],[-20,-34.6410161514,0],[-34.6410161514,-20,0],[-40,0,0],[-34.6410161514,20,0],[-20,34.6410161514,0],[0,40,0],[20,34.6410161514,0],[34.6410161514,20,0],[40,0,100],[34.6410161514,-20,100],[20,-34.6410161514,100],[0,-40,100],[-20,-34.6410161514,100],[-34.6410161514,-20,100],[-40,0,100],[-34.6410161514,20,100],[-20,34.6410161514,100],[0,40,100],[20,34.6410161514,100],[34.6410161514,20,100]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
    assert_approx(cylinder(d=80,h=100), [[[40,0,0],[34.6410161514,-20,0],[20,-34.6410161514,0],[0,-40,0],[-20,-34.6410161514,0],[-34.6410161514,-20,0],[-40,0,0],[-34.6410161514,20,0],[-20,34.6410161514,0],[0,40,0],[20,34.6410161514,0],[34.6410161514,20,0],[40,0,100],[34.6410161514,-20,100],[20,-34.6410161514,100],[0,-40,100],[-20,-34.6410161514,100],[-34.6410161514,-20,100],[-40,0,100],[-34.6410161514,20,100],[-20,34.6410161514,100],[0,40,100],[20,34.6410161514,100],[34.6410161514,20,100]],[[11,10,9,8,7,6,5,4,3,2,1,0],[0,13,12],[1,14,13],[2,15,14],[3,16,15],[4,17,16],[5,18,17],[6,19,18],[7,20,19],[8,21,20],[9,22,21],[10,23,22],[11,12,23],[0,1,13],[1,2,14],[2,3,15],[3,4,16],[4,5,17],[5,6,18],[6,7,19],[7,8,20],[8,9,21],[9,10,22],[10,11,23],[11,0,12],[12,13,14,15,16,17,18,19,20,21,22,23]]]);
}
test_cylinder();


module test_sphere() {
    $fn=6;
    assert_approx(sphere(r=40), [[[20,0,34.6410161514],[10,17.3205080757,34.6410161514],[-10,17.3205080757,34.6410161514],[-20,0,34.6410161514],[-10,-17.3205080757,34.6410161514],[10,-17.3205080757,34.6410161514],[40,0,0],[20,34.6410161514,0],[-20,34.6410161514,0],[-40,0,0],[-20,-34.6410161514,0],[20,-34.6410161514,0],[20,0,-34.6410161514],[10,17.3205080757,-34.6410161514],[-10,17.3205080757,-34.6410161514],[-20,0,-34.6410161514],[-10,-17.3205080757,-34.6410161514],[10,-17.3205080757,-34.6410161514]],[[5,4,3,2,1,0],[12,13,14,15,16,17],[6,0,1],[6,1,7],[7,1,2],[7,2,8],[8,2,3],[8,3,9],[9,3,4],[9,4,10],[10,4,5],[10,5,11],[11,5,0],[11,0,6],[12,6,7],[12,7,13],[13,7,8],[13,8,14],[14,8,9],[14,9,15],[15,9,10],[15,10,16],[16,10,11],[16,11,17],[17,11,6],[17,6,12]]]);
    assert_approx(sphere(r=40,style="orig"), [[[20,0,34.6410161514],[10,17.3205080757,34.6410161514],[-10,17.3205080757,34.6410161514],[-20,0,34.6410161514],[-10,-17.3205080757,34.6410161514],[10,-17.3205080757,34.6410161514],[40,0,0],[20,34.6410161514,0],[-20,34.6410161514,0],[-40,0,0],[-20,-34.6410161514,0],[20,-34.6410161514,0],[20,0,-34.6410161514],[10,17.3205080757,-34.6410161514],[-10,17.3205080757,-34.6410161514],[-20,0,-34.6410161514],[-10,-17.3205080757,-34.6410161514],[10,-17.3205080757,-34.6410161514]],[[5,4,3,2,1,0],[12,13,14,15,16,17],[6,0,1],[6,1,7],[7,1,2],[7,2,8],[8,2,3],[8,3,9],[9,3,4],[9,4,10],[10,4,5],[10,5,11],[11,5,0],[11,0,6],[12,6,7],[12,7,13],[13,7,8],[13,8,14],[14,8,9],[14,9,15],[15,9,10],[15,10,16],[16,10,11],[16,11,17],[17,11,6],[17,6,12]]]);
    assert_approx(sphere(r=40,style="aligned"), [[[0,0,40],[34.6410161514,0,20],[17.3205080757,30,20],[-17.3205080757,30,20],[-34.6410161514,0,20],[-17.3205080757,-30,20],[17.3205080757,-30,20],[34.6410161514,0,-20],[17.3205080757,30,-20],[-17.3205080757,30,-20],[-34.6410161514,0,-20],[-17.3205080757,-30,-20],[17.3205080757,-30,-20],[0,0,-40]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(sphere(r=40,style="stagger"), [[[0,0,40],[30,17.3205080757,20],[0,34.6410161514,20],[-30,17.3205080757,20],[-30,-17.3205080757,20],[0,-34.6410161514,20],[30,-17.3205080757,20],[34.6410161514,0,-20],[17.3205080757,30,-20],[-17.3205080757,30,-20],[-34.6410161514,0,-20],[-17.3205080757,-30,-20],[17.3205080757,-30,-20],[0,0,-40]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(sphere(r=40,style="octa"), [[[0,0,40],[28.2842712475,0,28.2842712475],[0,28.2842712475,28.2842712475],[-28.2842712475,0,28.2842712475],[0,-28.2842712475,28.2842712475],[40,0,0],[28.2842712475,28.2842712475,0],[0,40,0],[-28.2842712475,28.2842712475,0],[-40,0,0],[-28.2842712475,-28.2842712475,0],[0,-40,0],[28.2842712475,-28.2842712475,0],[28.2842712475,0,-28.2842712475],[0,28.2842712475,-28.2842712475],[-28.2842712475,0,-28.2842712475],[0,-28.2842712475,-28.2842712475],[0,0,-40]],[[0,2,1],[0,3,2],[0,4,3],[0,1,4],[17,15,16],[17,14,15],[17,13,14],[17,16,13],[1,6,5],[1,2,6],[13,5,6],[13,6,14],[2,7,6],[14,6,7],[2,8,7],[2,3,8],[14,7,8],[14,8,15],[3,9,8],[15,8,9],[3,10,9],[3,4,10],[15,9,10],[15,10,16],[4,11,10],[16,10,11],[4,12,11],[4,1,12],[16,11,12],[16,12,13],[1,5,12],[13,12,5]]]);
    assert_approx(sphere(r=40,style="icosa"),[[[0,21.0292444848,34.0260323341],[34.0260323341,0,21.0292444848],[21.0292444848,34.0260323341,0],[21.0292444848,34.0260323341,3.5527136788e-15],[34.0260323341,-3.5527136788e-15,21.0292444848],[34.0260323341,-1.7763568394e-15,-21.0292444848],[34.0260323341,-3.5527136788e-15,-21.0292444848],[34.0260323341,-8.881784197e-15,21.0292444848],[21.0292444848,-34.0260323341,0],[21.0292444848,-34.0260323341,5.3290705182e-15],[34.0260323341,-5.3290705182e-15,21.0292444848],[5.3290705182e-15,-21.0292444848,34.0260323341],[3.5527136788e-15,-21.0292444848,34.0260323341],[34.0260323341,3.5527136788e-15,21.0292444848],[3.5527136788e-15,21.0292444848,34.0260323341],[-21.0292444848,34.0260323341,-3.5527136788e-15],[21.0292444848,34.0260323341,-8.881784197e-15],[0,21.0292444848,-34.0260323341],[5.3290705182e-15,21.0292444848,-34.0260323341],[21.0292444848,34.0260323341,-5.3290705182e-15],[34.0260323341,5.3290705182e-15,-21.0292444848],[3.5527136788e-15,21.0292444848,34.0260323341],[21.0292444848,34.0260323341,-3.5527136788e-15],[-21.0292444848,34.0260323341,-1.7763568394e-15],[-34.0260323341,3.5527136788e-15,-21.0292444848],[-34.0260323341,8.881784197e-15,21.0292444848],[-21.0292444848,34.0260323341,0],[-21.0292444848,34.0260323341,5.3290705182e-15],[-34.0260323341,5.3290705182e-15,21.0292444848],[-5.3290705182e-15,21.0292444848,34.0260323341],[-3.5527136788e-15,21.0292444848,34.0260323341],[-34.0260323341,-3.5527136788e-15,21.0292444848],[-3.5527136788e-15,-21.0292444848,34.0260323341],[-5.39089693932e-15,-21.0292444848,34.0260323341],[-34.0260323341,-9.16854539271e-15,21.0292444848],[-21.0292444848,-34.0260323341,6.83383025096e-15],[-21.0292444848,-34.0260323341,3.5527136788e-15],[-34.0260323341,3.5527136788e-15,21.0292444848],[-34.0260323341,1.7763568394e-15,-21.0292444848],[34.0260323341,-5.39089693932e-15,-21.0292444848],[21.0292444848,-34.0260323341,-9.16854539271e-15],[6.83383025096e-15,-21.0292444848,-34.0260323341],[3.5527136788e-15,-21.0292444848,-34.0260323341],[21.0292444848,-34.0260323341,3.5527136788e-15],[-21.0292444848,-34.0260323341,1.7763568394e-15],[-21.0292444848,-34.0260323341,3.5527136788e-15],[21.0292444848,-34.0260323341,8.881784197e-15],[0,-21.0292444848,34.0260323341],[3.5527136788e-15,-21.0292444848,-34.0260323341],[8.881784197e-15,21.0292444848,-34.0260323341],[34.0260323341,0,-21.0292444848],[-34.0260323341,3.5527136788e-15,-21.0292444848],[3.5527136788e-15,21.0292444848,-34.0260323341],[1.7763568394e-15,-21.0292444848,-34.0260323341],[-21.0292444848,34.0260323341,-5.39089693932e-15],[-9.16854539271e-15,21.0292444848,-34.0260323341],[-34.0260323341,6.83383025096e-15,-21.0292444848],[-34.0260323341,-5.3290705182e-15,-21.0292444848],[-5.3290705182e-15,-21.0292444848,-34.0260323341],[-21.0292444848,-34.0260323341,-5.3290705182e-15]],[[0,1,2],[3,4,5],[6,7,8],[9,10,11],[12,13,14],[15,16,17],[18,19,20],[21,22,23],[24,25,26],[27,28,29],[30,31,32],[33,34,35],[36,37,38],[39,40,41],[42,43,44],[45,46,47],[48,49,50],[51,52,53],[54,55,56],[57,58,59]]]);
}
test_sphere();



module test_prismoid() {
    $fn=24;
    assert_approx(prismoid([100,80],[50,40],h=50), [[[25,20,50],[25,-20,50],[-25,-20,50],[-25,20,50],[50,40,0],[50,-40,0],[-50,-40,0],[-50,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[50,40],h=50,anchor=BOT), [[[25,20,50],[25,-20,50],[-25,-20,50],[-25,20,50],[50,40,0],[50,-40,0],[-50,-40,0],[-50,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[0,0],h=50,anchor=BOT), [[[0.000030517578125,0.000030517578125,50],[0.000030517578125,-0.000030517578125,50],[-0.000030517578125,-0.000030517578125,50],[-0.000030517578125,0.000030517578125,50],[50,40,0],[50,-40,0],[-50,-40,0],[-50,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,anchor=BOT), [[[20,25,50],[20,-25,50],[-20,-25,50],[-20,25,50],[50,40,0],[50,-40,0],[-50,-40,0],[-50,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,anchor=TOP+RIGHT), [[[0,25,0],[0,-25,0],[-40,-25,0],[-40,25,0],[30,40,-50],[30,-40,-50],[-70,-40,-50],[-70,40,-50]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5]), [[[30,30,50],[30,-20,50],[-10,-20,50],[-10,30,50],[50,40,0],[50,-40,0],[-50,-40,0],[-50,40,0]],[[0,1,2],[0,2,3],[0,4,5],[0,5,1],[1,5,6],[1,6,2],[2,6,7],[2,7,3],[3,7,4],[3,4,0],[4,7,6],[4,6,5]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer=5), [[[50,-35,0],[45,-40,0],[-45,-40,0],[-50,-35,0],[-50,35,0],[-45,40,0],[45,40,0],[50,35,0],[30,-15,50],[25,-20,50],[-5,-20,50],[-10,-15,50],[-10,25,50],[-5,30,50],[25,30,50],[30,25,50]],[[14,7,15],[7,8,15],[8,14,15],[5,14,13],[14,12,13],[12,5,13],[14,11,12],[11,4,12],[4,5,12],[14,10,11],[3,4,11],[10,3,11],[2,3,10],[9,2,10],[14,9,10],[14,8,9],[1,2,9],[8,1,9],[7,0,8],[0,1,8],[14,6,7],[6,0,7],[14,5,6],[5,0,6],[4,0,5],[2,4,3],[1,4,2],[4,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer1=5), [[[50,-35,0],[45,-40,0],[-45,-40,0],[-50,-35,0],[-50,35,0],[-45,40,0],[45,40,0],[50,35,0],[30,-20,50],[-10,-20,50],[-10,30,50],[30,30,50]],[[11,9,10],[9,4,10],[4,5,10],[5,11,10],[2,3,9],[8,2,9],[11,8,9],[3,4,9],[1,2,8],[11,0,8],[0,1,8],[0,11,7],[11,6,7],[6,0,7],[11,5,6],[5,0,6],[4,0,5],[2,4,3],[1,4,2],[4,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer2=5), [[[50,-40,0],[-50,-40,0],[-50,40,0],[50,40,0],[30,-15,50],[25,-20,50],[-5,-20,50],[-10,-15,50],[-10,25,50],[-5,30,50],[25,30,50],[30,25,50]],[[10,3,11],[3,4,11],[4,10,11],[2,10,9],[10,8,9],[8,2,9],[10,7,8],[7,2,8],[1,2,7],[6,1,7],[10,6,7],[10,5,6],[5,1,6],[10,4,5],[0,1,5],[4,0,5],[3,0,4],[10,2,3],[2,0,3],[2,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer1=5,chamfer2=10), [[[50,-35,0],[45,-40,0],[-45,-40,0],[-50,-35,0],[-50,35,0],[-45,40,0],[45,40,0],[50,35,0],[30,-10,50],[20,-20,50],[0,-20,50],[-10,-10,50],[-10,20,50],[0,30,50],[20,30,50],[30,20,50]],[[14,7,15],[7,8,15],[8,14,15],[5,14,13],[14,12,13],[12,5,13],[14,11,12],[11,4,12],[4,5,12],[14,10,11],[3,4,11],[10,3,11],[2,3,10],[9,2,10],[14,9,10],[14,8,9],[1,2,9],[8,1,9],[7,0,8],[0,1,8],[14,6,7],[6,0,7],[14,5,6],[5,0,6],[4,0,5],[2,4,3],[1,4,2],[4,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],rounding=5), [[[50,-35,0],[49.8296291314,-36.2940952255,0],[49.3301270189,-37.5,0],[48.5355339059,-38.5355339059,0],[47.5,-39.3301270189,0],[46.2940952255,-39.8296291314,0],[45,-40,0],[-45,-40,0],[-46.2940952255,-39.8296291314,0],[-47.5,-39.3301270189,0],[-48.5355339059,-38.5355339059,0],[-49.3301270189,-37.5,0],[-49.8296291314,-36.2940952255,0],[-50,-35,0],[-50,35,0],[-49.8296291314,36.2940952255,0],[-49.3301270189,37.5,0],[-48.5355339059,38.5355339059,0],[-47.5,39.3301270189,0],[-46.2940952255,39.8296291314,0],[-45,40,0],[45,40,0],[46.2940952255,39.8296291314,0],[47.5,39.3301270189,0],[48.5355339059,38.5355339059,0],[49.3301270189,37.5,0],[49.8296291314,36.2940952255,0],[50,35,0],[30,-15,50],[29.8296291314,-16.2940952255,50],[29.3301270189,-17.5,50],[28.5355339059,-18.5355339059,50],[27.5,-19.3301270189,50],[26.2940952255,-19.8296291314,50],[25,-20,50],[-5,-20,50],[-6.29409522551,-19.8296291314,50],[-7.5,-19.3301270189,50],[-8.53553390593,-18.5355339059,50],[-9.33012701892,-17.5,50],[-9.82962913145,-16.2940952255,50],[-10,-15,50],[-10,25,50],[-9.82962913145,26.2940952255,50],[-9.33012701892,27.5,50],[-8.53553390593,28.5355339059,50],[-7.5,29.3301270189,50],[-6.29409522551,29.8296291314,50],[-5,30,50],[25,30,50],[26.2940952255,29.8296291314,50],[27.5,29.3301270189,50],[28.5355339059,28.5355339059,50],[29.3301270189,27.5,50],[29.8296291314,26.2940952255,50],[30,25,50]],[[27,28,55],[28,54,55],[54,27,55],[28,53,54],[26,27,54],[53,26,54],[28,52,53],[25,26,53],[52,25,53],[28,51,52],[51,24,52],[24,25,52],[22,51,50],[51,49,50],[49,22,50],[51,48,49],[48,21,49],[21,22,49],[20,21,48],[47,20,48],[51,47,48],[19,20,47],[46,19,47],[51,46,47],[51,45,46],[18,19,46],[45,18,46],[51,44,45],[17,18,45],[44,17,45],[16,17,44],[43,16,44],[51,43,44],[15,16,43],[42,15,43],[51,42,43],[14,15,42],[41,14,42],[51,41,42],[13,14,41],[40,13,41],[51,40,41],[12,13,40],[39,12,40],[51,39,40],[11,12,39],[38,11,39],[51,38,39],[10,11,38],[37,10,38],[51,37,38],[9,10,37],[36,9,37],[51,36,37],[8,9,36],[35,8,36],[51,35,36],[7,8,35],[34,7,35],[51,34,35],[6,7,34],[33,6,34],[51,33,34],[51,32,33],[5,6,33],[32,5,33],[51,31,32],[4,5,32],[31,4,32],[51,30,31],[3,4,31],[30,3,31],[51,29,30],[2,3,30],[29,2,30],[51,28,29],[1,2,29],[28,1,29],[27,0,28],[0,1,28],[26,0,27],[25,0,26],[24,0,25],[51,23,24],[23,0,24],[51,22,23],[22,0,23],[21,0,22],[20,0,21],[19,0,20],[18,0,19],[17,0,18],[16,0,17],[14,16,15],[13,16,14],[12,16,13],[11,16,12],[10,16,11],[9,16,10],[8,16,9],[7,16,8],[6,16,7],[5,16,6],[4,16,5],[3,16,4],[2,16,3],[1,16,2],[16,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],rounding1=5), [[[50,-35,0],[49.8296291314,-36.2940952255,0],[49.3301270189,-37.5,0],[48.5355339059,-38.5355339059,0],[47.5,-39.3301270189,0],[46.2940952255,-39.8296291314,0],[45,-40,0],[-45,-40,0],[-46.2940952255,-39.8296291314,0],[-47.5,-39.3301270189,0],[-48.5355339059,-38.5355339059,0],[-49.3301270189,-37.5,0],[-49.8296291314,-36.2940952255,0],[-50,-35,0],[-50,35,0],[-49.8296291314,36.2940952255,0],[-49.3301270189,37.5,0],[-48.5355339059,38.5355339059,0],[-47.5,39.3301270189,0],[-46.2940952255,39.8296291314,0],[-45,40,0],[45,40,0],[46.2940952255,39.8296291314,0],[47.5,39.3301270189,0],[48.5355339059,38.5355339059,0],[49.3301270189,37.5,0],[49.8296291314,36.2940952255,0],[50,35,0],[30,-20,50],[-10,-20,50],[-10,30,50],[30,30,50]],[[16,17,30],[31,29,30],[15,16,30],[14,15,30],[29,14,30],[19,20,30],[20,31,30],[18,19,30],[17,18,30],[12,13,29],[31,28,29],[11,12,29],[10,11,29],[9,10,29],[8,9,29],[7,8,29],[28,7,29],[13,14,29],[6,7,28],[5,6,28],[4,5,28],[3,4,28],[2,3,28],[1,2,28],[31,0,28],[0,1,28],[0,31,27],[31,26,27],[26,0,27],[31,25,26],[25,0,26],[31,24,25],[24,0,25],[31,23,24],[23,0,24],[31,22,23],[22,0,23],[31,21,22],[21,0,22],[31,20,21],[20,0,21],[19,0,20],[18,0,19],[17,0,18],[16,0,17],[14,16,15],[13,16,14],[12,16,13],[11,16,12],[10,16,11],[9,16,10],[8,16,9],[7,16,8],[6,16,7],[5,16,6],[4,16,5],[3,16,4],[2,16,3],[1,16,2],[16,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],rounding2=5), [[[50,-40,0],[-50,-40,0],[-50,40,0],[50,40,0],[30,-15,50],[29.8296291314,-16.2940952255,50],[29.3301270189,-17.5,50],[28.5355339059,-18.5355339059,50],[27.5,-19.3301270189,50],[26.2940952255,-19.8296291314,50],[25,-20,50],[-5,-20,50],[-6.29409522551,-19.8296291314,50],[-7.5,-19.3301270189,50],[-8.53553390593,-18.5355339059,50],[-9.33012701892,-17.5,50],[-9.82962913145,-16.2940952255,50],[-10,-15,50],[-10,25,50],[-9.82962913145,26.2940952255,50],[-9.33012701892,27.5,50],[-8.53553390593,28.5355339059,50],[-7.5,29.3301270189,50],[-6.29409522551,29.8296291314,50],[-5,30,50],[25,30,50],[26.2940952255,29.8296291314,50],[27.5,29.3301270189,50],[28.5355339059,28.5355339059,50],[29.3301270189,27.5,50],[29.8296291314,26.2940952255,50],[30,25,50]],[[3,4,31],[4,30,31],[30,3,31],[4,29,30],[29,3,30],[28,3,29],[4,28,29],[3,28,27],[28,26,27],[26,3,27],[28,25,26],[25,3,26],[28,24,25],[24,3,25],[2,3,24],[23,2,24],[28,23,24],[22,2,23],[28,22,23],[28,21,22],[21,2,22],[28,20,21],[20,2,21],[28,19,20],[19,2,20],[28,18,19],[18,2,19],[28,17,18],[17,2,18],[1,2,17],[16,1,17],[28,16,17],[15,1,16],[28,15,16],[14,1,15],[28,14,15],[13,1,14],[28,13,14],[12,1,13],[28,12,13],[11,1,12],[28,11,12],[10,1,11],[28,10,11],[0,1,10],[9,0,10],[28,9,10],[8,0,9],[28,8,9],[28,7,8],[7,0,8],[28,6,7],[6,0,7],[28,5,6],[5,0,6],[28,4,5],[4,0,5],[3,0,4],[2,0,3],[2,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],rounding1=5,rounding2=10), [[[50,-35,0],[49.8296291314,-36.2940952255,0],[49.3301270189,-37.5,0],[48.5355339059,-38.5355339059,0],[47.5,-39.3301270189,0],[46.2940952255,-39.8296291314,0],[45,-40,0],[-45,-40,0],[-46.2940952255,-39.8296291314,0],[-47.5,-39.3301270189,0],[-48.5355339059,-38.5355339059,0],[-49.3301270189,-37.5,0],[-49.8296291314,-36.2940952255,0],[-50,-35,0],[-50,35,0],[-49.8296291314,36.2940952255,0],[-49.3301270189,37.5,0],[-48.5355339059,38.5355339059,0],[-47.5,39.3301270189,0],[-46.2940952255,39.8296291314,0],[-45,40,0],[45,40,0],[46.2940952255,39.8296291314,0],[47.5,39.3301270189,0],[48.5355339059,38.5355339059,0],[49.3301270189,37.5,0],[49.8296291314,36.2940952255,0],[50,35,0],[30,-10,50],[29.6592582629,-12.588190451,50],[28.6602540378,-15,50],[27.0710678119,-17.0710678119,50],[25,-18.6602540378,50],[22.588190451,-19.6592582629,50],[20,-20,50],[0,-20,50],[-2.58819045103,-19.6592582629,50],[-5,-18.6602540378,50],[-7.07106781187,-17.0710678119,50],[-8.66025403784,-15,50],[-9.65925826289,-12.588190451,50],[-10,-10,50],[-10,20,50],[-9.65925826289,22.588190451,50],[-8.66025403784,25,50],[-7.07106781187,27.0710678119,50],[-5,28.6602540378,50],[-2.58819045103,29.6592582629,50],[0,30,50],[20,30,50],[22.588190451,29.6592582629,50],[25,28.6602540378,50],[27.0710678119,27.0710678119,50],[28.6602540378,25,50],[29.6592582629,22.588190451,50],[30,20,50]],[[27,28,55],[28,54,55],[54,27,55],[28,53,54],[26,27,54],[53,26,54],[28,52,53],[25,26,53],[52,25,53],[28,51,52],[51,24,52],[24,25,52],[22,51,50],[51,49,50],[49,22,50],[51,48,49],[48,21,49],[21,22,49],[20,21,48],[47,20,48],[51,47,48],[19,20,47],[46,19,47],[51,46,47],[18,19,46],[45,18,46],[51,45,46],[17,18,45],[44,17,45],[51,44,45],[16,17,44],[43,16,44],[51,43,44],[15,16,43],[42,15,43],[51,42,43],[14,15,42],[41,14,42],[51,41,42],[13,14,41],[40,13,41],[51,40,41],[12,13,40],[39,12,40],[51,39,40],[11,12,39],[38,11,39],[51,38,39],[10,11,38],[37,10,38],[51,37,38],[9,10,37],[36,9,37],[51,36,37],[8,9,36],[35,8,36],[51,35,36],[7,8,35],[34,7,35],[51,34,35],[6,7,34],[33,6,34],[51,33,34],[51,32,33],[5,6,33],[32,5,33],[51,31,32],[4,5,32],[31,4,32],[51,30,31],[3,4,31],[30,3,31],[51,29,30],[2,3,30],[29,2,30],[51,28,29],[1,2,29],[28,1,29],[27,0,28],[0,1,28],[26,0,27],[25,0,26],[24,0,25],[51,23,24],[23,0,24],[51,22,23],[22,0,23],[21,0,22],[20,0,21],[19,0,20],[18,0,19],[17,0,18],[16,0,17],[14,16,15],[13,16,14],[12,16,13],[11,16,12],[10,16,11],[9,16,10],[8,16,9],[7,16,8],[6,16,7],[5,16,6],[4,16,5],[3,16,4],[2,16,3],[1,16,2],[16,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],rounding1=5,chamfer2=10), [[[50,-35,0],[49.8296291314,-36.2940952255,0],[49.3301270189,-37.5,0],[48.5355339059,-38.5355339059,0],[47.5,-39.3301270189,0],[46.2940952255,-39.8296291314,0],[45,-40,0],[-45,-40,0],[-46.2940952255,-39.8296291314,0],[-47.5,-39.3301270189,0],[-48.5355339059,-38.5355339059,0],[-49.3301270189,-37.5,0],[-49.8296291314,-36.2940952255,0],[-50,-35,0],[-50,35,0],[-49.8296291314,36.2940952255,0],[-49.3301270189,37.5,0],[-48.5355339059,38.5355339059,0],[-47.5,39.3301270189,0],[-46.2940952255,39.8296291314,0],[-45,40,0],[45,40,0],[46.2940952255,39.8296291314,0],[47.5,39.3301270189,0],[48.5355339059,38.5355339059,0],[49.3301270189,37.5,0],[49.8296291314,36.2940952255,0],[50,35,0],[30,-10,50],[20,-20,50],[0,-20,50],[-10,-10,50],[-10,20,50],[0,30,50],[20,30,50],[30,20,50]],[[24,25,35],[34,24,35],[25,26,35],[28,34,35],[26,27,35],[27,28,35],[22,23,34],[21,22,34],[33,21,34],[28,33,34],[23,24,34],[18,19,33],[17,18,33],[32,17,33],[19,20,33],[28,32,33],[20,21,33],[16,17,32],[15,16,32],[14,15,32],[31,14,32],[28,31,32],[13,14,31],[12,13,31],[11,12,31],[10,11,31],[30,10,31],[28,30,31],[28,29,30],[9,10,30],[8,9,30],[7,8,30],[29,7,30],[6,7,29],[5,6,29],[4,5,29],[28,3,29],[3,4,29],[0,28,27],[26,0,27],[25,0,26],[24,0,25],[23,0,24],[22,0,23],[21,0,22],[20,0,21],[19,0,20],[18,0,19],[17,0,18],[16,0,17],[14,16,15],[13,16,14],[12,16,13],[11,16,12],[10,16,11],[9,16,10],[7,9,8],[6,9,7],[5,9,6],[4,9,5],[3,9,4],[28,2,3],[2,9,3],[28,1,2],[1,9,2],[28,0,1],[0,9,1],[0,16,9]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer=[0,5,10,15]), [[[50,-25,0],[35,-40,0],[-40,-40,0],[-50,-30,0],[-50,35,0],[-45,40,0],[50,40,0],[30,-5,50],[15,-20,50],[0,-20,50],[-10,-10,50],[-10,25,50],[-5,30,50],[30,30,50]],[[5,13,12],[13,11,12],[11,5,12],[13,10,11],[10,4,11],[4,5,11],[13,9,10],[3,4,10],[9,3,10],[2,3,9],[8,2,9],[13,8,9],[13,7,8],[1,2,8],[7,1,8],[13,0,7],[0,1,7],[0,13,6],[13,5,6],[5,0,6],[4,0,5],[2,4,3],[1,4,2],[4,1,0]]]);
    assert_approx(prismoid([100,80],[40,50],h=50,shift=[10,5],chamfer1=[15,10,5,0], rounding2=[0,5,10,15]),  [[[50,-40,0],[-45,-40,0],[-50,-35,0],[-50,30,0],[-40,40,0],[35,40,0],[50,25,0],[30,-5,50],[29.4888873943,-8.88228567654,50],[27.9903810568,-12.5,50],[25.6066017178,-15.6066017178,50],[22.5,-17.9903810568,50],[18.8822856765,-19.4888873943,50],[15,-20,50],[0,-20,50],[-2.58819045103,-19.6592582629,50],[-5,-18.6602540378,50],[-7.07106781187,-17.0710678119,50],[-8.66025403784,-15,50],[-9.65925826289,-12.588190451,50],[-10,-10,50],[-10,25,50],[-9.82962913145,26.2940952255,50],[-9.33012701892,27.5,50],[-8.53553390593,28.5355339059,50],[-7.5,29.3301270189,50],[-6.29409522551,29.8296291314,50],[-5,30,50],[30,30,50]],[[4,28,27],[28,26,27],[26,4,27],[28,25,26],[25,4,26],[28,24,25],[24,4,25],[3,4,24],[23,3,24],[28,23,24],[22,3,23],[28,22,23],[21,3,22],[28,21,22],[28,20,21],[20,3,21],[28,19,20],[2,3,20],[19,2,20],[28,18,19],[18,2,19],[28,17,18],[17,2,18],[1,2,17],[16,1,17],[28,16,17],[15,1,16],[28,15,16],[14,1,15],[28,14,15],[13,1,14],[28,13,14],[0,1,13],[12,0,13],[28,12,13],[11,0,12],[28,11,12],[10,0,11],[28,10,11],[9,0,10],[28,9,10],[8,0,9],[28,8,9],[28,7,8],[7,0,8],[28,0,7],[0,28,6],[28,5,6],[5,0,6],[28,4,5],[4,0,5],[3,0,4],[1,3,2],[3,1,0]]]);
}
test_prismoid();


module test_spheroid() {
    $fn=6;
    assert_approx(spheroid(r=50),[[[0,0,50],[43.3012701892,0,25],[21.6506350946,37.5,25],[-21.6506350946,37.5,25],[-43.3012701892,0,25],[-21.6506350946,-37.5,25],[21.6506350946,-37.5,25],[43.3012701892,0,-25],[21.6506350946,37.5,-25],[-21.6506350946,37.5,-25],[-43.3012701892,0,-25],[-21.6506350946,-37.5,-25],[21.6506350946,-37.5,-25],[0,0,-50]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(spheroid(d=100),[[[0,0,50],[43.3012701892,0,25],[21.6506350946,37.5,25],[-21.6506350946,37.5,25],[-43.3012701892,0,25],[-21.6506350946,-37.5,25],[21.6506350946,-37.5,25],[43.3012701892,0,-25],[21.6506350946,37.5,-25],[-21.6506350946,37.5,-25],[-43.3012701892,0,-25],[-21.6506350946,-37.5,-25],[21.6506350946,-37.5,-25],[0,0,-50]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(spheroid(r=50,circum=true), [[[0,0,57.735026919],[28.8675134595,50,28.8675134595],[-28.8675134595,50,28.8675134595],[-57.735026919,-3.5527136788e-15,28.8675134595],[-28.8675134595,-50,28.8675134595],[28.8675134595,-50,28.8675134595],[57.735026919,3.5527136788e-15,28.8675134595],[28.8675134595,50,-28.8675134595],[-28.8675134595,50,-28.8675134595],[-57.735026919,-3.5527136788e-15,-28.8675134595],[-28.8675134595,-50,-28.8675134595],[28.8675134595,-50,-28.8675134595],[57.735026919,3.5527136788e-15,-28.8675134595],[0,0,-57.735026919]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(spheroid(r=50,style="orig"),[[[25,0,43.3012701892],[12.5,21.6506350946,43.3012701892],[-12.5,21.6506350946,43.3012701892],[-25,0,43.3012701892],[-12.5,-21.6506350946,43.3012701892],[12.5,-21.6506350946,43.3012701892],[50,0,0],[25,43.3012701892,0],[-25,43.3012701892,0],[-50,0,0],[-25,-43.3012701892,0],[25,-43.3012701892,0],[25,0,-43.3012701892],[12.5,21.6506350946,-43.3012701892],[-12.5,21.6506350946,-43.3012701892],[-25,0,-43.3012701892],[-12.5,-21.6506350946,-43.3012701892],[12.5,-21.6506350946,-43.3012701892]],[[5,4,3,2,1,0],[12,13,14,15,16,17],[6,0,1],[6,1,7],[7,1,2],[7,2,8],[8,2,3],[8,3,9],[9,3,4],[9,4,10],[10,4,5],[10,5,11],[11,5,0],[11,0,6],[12,6,7],[12,7,13],[13,7,8],[13,8,14],[14,8,9],[14,9,15],[15,9,10],[15,10,16],[16,10,11],[16,11,17],[17,11,6],[17,6,12]]]);
    assert_approx(spheroid(r=50,style="aligned"),[[[0,0,50],[43.3012701892,0,25],[21.6506350946,37.5,25],[-21.6506350946,37.5,25],[-43.3012701892,0,25],[-21.6506350946,-37.5,25],[21.6506350946,-37.5,25],[43.3012701892,0,-25],[21.6506350946,37.5,-25],[-21.6506350946,37.5,-25],[-43.3012701892,0,-25],[-21.6506350946,-37.5,-25],[21.6506350946,-37.5,-25],[0,0,-50]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(spheroid(r=50,style="stagger"),[[[0,0,50],[37.5,21.6506350946,25],[0,43.3012701892,25],[-37.5,21.6506350946,25],[-37.5,-21.6506350946,25],[0,-43.3012701892,25],[37.5,-21.6506350946,25],[43.3012701892,0,-25],[21.6506350946,37.5,-25],[-21.6506350946,37.5,-25],[-43.3012701892,0,-25],[-21.6506350946,-37.5,-25],[21.6506350946,-37.5,-25],[0,0,-50]],[[1,0,2],[13,7,8],[2,0,3],[13,8,9],[3,0,4],[13,9,10],[4,0,5],[13,10,11],[5,0,6],[13,11,12],[6,0,1],[13,12,7],[1,2,8],[1,8,7],[2,3,9],[2,9,8],[3,4,10],[3,10,9],[4,5,11],[4,11,10],[5,6,12],[5,12,11],[6,1,7],[6,7,12]]]);
    assert_approx(spheroid(r=50,style="octa"),[[[0,0,50],[35.3553390593,0,35.3553390593],[0,35.3553390593,35.3553390593],[-35.3553390593,0,35.3553390593],[0,-35.3553390593,35.3553390593],[50,0,0],[35.3553390593,35.3553390593,0],[0,50,0],[-35.3553390593,35.3553390593,0],[-50,0,0],[-35.3553390593,-35.3553390593,0],[0,-50,0],[35.3553390593,-35.3553390593,0],[35.3553390593,0,-35.3553390593],[0,35.3553390593,-35.3553390593],[-35.3553390593,0,-35.3553390593],[0,-35.3553390593,-35.3553390593],[0,0,-50]],[[0,2,1],[0,3,2],[0,4,3],[0,1,4],[17,15,16],[17,14,15],[17,13,14],[17,16,13],[1,6,5],[1,2,6],[13,5,6],[13,6,14],[2,7,6],[14,6,7],[2,8,7],[2,3,8],[14,7,8],[14,8,15],[3,9,8],[15,8,9],[3,10,9],[3,4,10],[15,9,10],[15,10,16],[4,11,10],[16,10,11],[4,12,11],[4,1,12],[16,11,12],[16,12,13],[1,5,12],[13,12,5]]]);
    assert_approx(spheroid(r=50,style="icosa"),[[[0,26.286555606,42.5325404176],[42.5325404176,0,26.286555606],[26.286555606,42.5325404176,0],[26.286555606,42.5325404176,3.5527136788e-15],[42.5325404176,-7.1054273576e-15,26.286555606],[42.5325404176,-1.7763568394e-15,-26.286555606],[42.5325404176,-3.5527136788e-15,-26.286555606],[42.5325404176,-1.24344978758e-14,26.286555606],[26.286555606,-42.5325404176,0],[26.286555606,-42.5325404176,5.3290705182e-15],[42.5325404176,-7.1054273576e-15,26.286555606],[5.3290705182e-15,-26.286555606,42.5325404176],[5.3290705182e-15,-26.286555606,42.5325404176],[42.5325404176,7.1054273576e-15,26.286555606],[3.5527136788e-15,26.286555606,42.5325404176],[-26.286555606,42.5325404176,-3.5527136788e-15],[26.286555606,42.5325404176,-1.24344978758e-14],[0,26.286555606,-42.5325404176],[5.3290705182e-15,26.286555606,-42.5325404176],[26.286555606,42.5325404176,-7.1054273576e-15],[42.5325404176,5.3290705182e-15,-26.286555606],[3.5527136788e-15,26.286555606,42.5325404176],[26.286555606,42.5325404176,-7.1054273576e-15],[-26.286555606,42.5325404176,-1.7763568394e-15],[-42.5325404176,3.5527136788e-15,-26.286555606],[-42.5325404176,1.24344978758e-14,26.286555606],[-26.286555606,42.5325404176,0],[-26.286555606,42.5325404176,5.3290705182e-15],[-42.5325404176,7.1054273576e-15,26.286555606],[-5.3290705182e-15,26.286555606,42.5325404176],[-5.3290705182e-15,26.286555606,42.5325404176],[-42.5325404176,-7.1054273576e-15,26.286555606],[-3.5527136788e-15,-26.286555606,42.5325404176],[-6.73862117414e-15,-26.286555606,42.5325404176],[-42.5325404176,-1.14606817409e-14,26.286555606],[-26.286555606,-42.5325404176,8.5422878137e-15],[-26.286555606,-42.5325404176,3.5527136788e-15],[-42.5325404176,7.1054273576e-15,26.286555606],[-42.5325404176,1.7763568394e-15,-26.286555606],[42.5325404176,-6.73862117414e-15,-26.286555606],[26.286555606,-42.5325404176,-1.14606817409e-14],[8.5422878137e-15,-26.286555606,-42.5325404176],[3.5527136788e-15,-26.286555606,-42.5325404176],[26.286555606,-42.5325404176,7.1054273576e-15],[-26.286555606,-42.5325404176,1.7763568394e-15],[-26.286555606,-42.5325404176,3.5527136788e-15],[26.286555606,-42.5325404176,1.24344978758e-14],[0,-26.286555606,42.5325404176],[3.5527136788e-15,-26.286555606,-42.5325404176],[1.24344978758e-14,26.286555606,-42.5325404176],[42.5325404176,0,-26.286555606],[-42.5325404176,3.5527136788e-15,-26.286555606],[7.1054273576e-15,26.286555606,-42.5325404176],[1.7763568394e-15,-26.286555606,-42.5325404176],[-26.286555606,42.5325404176,-6.73862117414e-15],[-1.14606817409e-14,26.286555606,-42.5325404176],[-42.5325404176,8.5422878137e-15,-26.286555606],[-42.5325404176,-5.3290705182e-15,-26.286555606],[-7.1054273576e-15,-26.286555606,-42.5325404176],[-26.286555606,-42.5325404176,-5.3290705182e-15]],[[0,1,2],[3,4,5],[6,7,8],[9,10,11],[12,13,14],[15,16,17],[18,19,20],[21,22,23],[24,25,26],[27,28,29],[30,31,32],[33,34,35],[36,37,38],[39,40,41],[42,43,44],[45,46,47],[48,49,50],[51,52,53],[54,55,56],[57,58,59]]]);
}
test_spheroid();


module test_cyl() {
    $fn=12;
    shape_compare() {
        cyl(r=50,l=10,circum=true,anchor=BOTTOM);
        cylinder(r=50/cos(180/12),l=10);
    }
    shape_compare() {
        cyl(r=50,l=10,circum=false,anchor=BOTTOM);
        cylinder(r=50,l=10);
    }
    shape_compare() {
        cyl(r=50,l=10,chamfer=1,circum=true,anchor=BOTTOM);
        union() {
            r=50/cos(180/12);
            cylinder(r1=r-1,r2=r,l=1);
            up(1) cylinder(r=r,l=8);
            up(9) cylinder(r1=r,r2=r-1,l=1);
        }
    }
    shape_compare() {
        cyl(r=50,l=10,chamfer=1,circum=false,anchor=BOTTOM);
        union() {
            r=50;
            cylinder(r1=r-1,r2=r,l=1);
            up(1) cylinder(r=r,l=8);
            up(9) cylinder(r1=r,r2=r-1,l=1);
        }
    }
}
test_cyl();



// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
