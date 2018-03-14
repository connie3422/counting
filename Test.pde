void runTests() {
    add_fiducial_to_depth0Child1();
    //add_fiducial_to_depth0Child2();
}

void add_fiducial_to_depth0Child1() {
    //for (Item child: view.root.children) {
    //  System.out.println(child.x + ", " + child.y);
    //}
    view.add_fiducial(50, 470, 133);
    Item depth1Child1 = view.root.children.get(0);
    Item depth1Child2 = view.root.children.get(1);
    Item depth1Child3 = view.root.children.get(2);
    //assert(depth1Child1.parent.remaining_options.get(50) == false);
    //assert(depth1Child1.parent.remaining_options.get(49) == true);
    //assert(depth1Child1.parent.remaining_options.get(48) == true);
    assert(depth1Child1.state == 2);
    assert(depth1Child1.children.size() == 2);
    Item depth2Child1 = depth1Child1.children.get(0);
    Item depth2Child2 = depth1Child1.children.get(1);
    assert(depth2Child1.remaining_options.size() == 2);
    System.out.println(Arrays.asList("21 " + depth2Child1.remaining_options));
    System.out.println(Arrays.asList("22 " + depth2Child2.remaining_options));
    System.out.println(Arrays.asList("11 " + depth1Child1.remaining_options));
    System.out.println(Arrays.asList("12 " + depth1Child2.remaining_options));
    System.out.println(Arrays.asList("13 " + depth1Child3.remaining_options));
    System.out.println(Arrays.asList("root " +view.root.remaining_options));
}

void add_fiducial_to_depth0Child2() {
    //for (Item child: view.root.children) {
    //  System.out.println(child.x + ", " + child.y);
    //}
    view.add_fiducial(50, 470, 400);
    Item depth0Child1 = view.root.children.get(0);
    assert(depth0Child1.parent.remaining_options.get(50) == false);
    assert(depth0Child1.parent.remaining_options.get(49) == true);
    assert(depth0Child1.parent.remaining_options.get(48) == true);
    assert(depth0Child1.state == 2);
    assert(depth0Child1.children.size() == 2);
    Item depth1Child1 = depth0Child1.children.get(0);
    assert(depth1Child1.remaining_options.size() == 2);
    System.out.println(Arrays.asList(depth1Child1.remaining_options));
}