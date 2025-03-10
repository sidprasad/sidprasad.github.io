
/** COnstants */
const initialUnconstrainedIterations = 10; //unconstrained initial layout iterations
const initialUserConstraintIterations = 100; // initial layout iterations with user-specified constraints
const initialAllConstraintsIterations = 50; // initial layout iterations with all constraints including non-overlap
const gridSnapIterations = 5; // iterations of "grid snap", which pulls nodes towards grid cell centers - grid of size node[0].width - only really makes sense if all nodes have the same width and heigh
const margin = 10;
const dy_for_linespacing = 5; // Adjust for spacing between lines
//////////


function adjustPointToRectanglePerimeter(point, rect) {
    const { x, y, width, height } = rect;
    const padding = 3; // Padding in pixels

    const tl_X = x - padding;
    const tl_Y = y - padding;
    const br_X = x + width + padding;
    const br_Y = y + height + padding;

    if (point.x < tl_X) {
        point.x = tl_X;
    }
    else if (point.x > br_X) {
        point.x = br_X;
    }

    if (point.y < tl_Y) {
        point.y = tl_Y;
    }
    else if (point.y > br_Y) {
        point.y = br_Y;
    }
    return point;
}

// Function to generate a random offset along the path
function getRandomOffsetAlongPath() {
    return (Math.random() - 0.5) * 20; // Random value between -10 and 10
}




function setupLayout(d3, nodes, edges, constraints, groups, width, height) {


    // Create a zoom behavior
    var zoom = d3.zoom()
        .scaleExtent([0.5, 5]) // Set the zoom scale limits
        .on("zoom", zoomed);

    function zoomed() {
        d3.select(".zoomable").attr("transform", d3.event.transform);
    }

    function getNodeIndex(nodeId) {
        return nodes.findIndex(node => node.id === nodeId);
    }

    const LINK_DISTANCE = Math.min(width, height) / Math.sqrt(nodes.length);

    nodes.forEach(function (node) {
        node.name = node.id;
    });


    var color = d3.scaleOrdinal(d3.schemeCategory20);
    var svg_top = d3.select("#svg").call(zoom);
    var svg = d3.select(".zoomable");

    var colaLayout = cola.d3adaptor(d3)
        //.convergenceThreshold(0.1) // TODO: What should we do here?
        .avoidOverlaps(true)
        .handleDisconnected(true)
        .size([width, height]);

    const min_sep = 50;
    const default_node_width = 70;
    

    colaLayout
        .nodes(nodes)
        .links(edges)
        .constraints(constraints)
        .groups(groups)
        .groupCompactness(1e-3)
        .flowLayout("y", 100) // This is in line with the DAGRE estimate
        .symmetricDiffLinkLengths(min_sep + default_node_width, 0.1);
        //.linkDistance(50); // I *think* this is minimum link distance

    var lineFunction = d3.line()
        .x(function (d) { return d.x; })
        .y(function (d) { return d.y; })
        .curve(d3.curveBasis);


    var routeEdges = function () {
        colaLayout.prepareEdgeRouting(margin / 3);
        console.log("Routing edges");



        // What I want to do is change the angle based on the number of edges between the same nodes
        // Function to calculate curvature based on number of edges and index
        function calculateCurvature(edges, fromNode, toNode, edgeid) {
            const sourceIndex = getNodeIndex(fromNode);
            const targetIndex = getNodeIndex(toNode);

            // Get all edges between the two nodes, regardless of direction
            const allEdges = edges.filter(edge => {
                return (edge.source.id == fromNode && edge.target.id == toNode) ||
                    (edge.source.id == toNode && edge.target.id == fromNode);
            });

            const edgeCount = allEdges.length;
            let index = allEdges.findIndex(edge => edge.id == edgeid);

            // Calculate curvature
            let curvature = 0;
            if (edgeCount > 1) {
                curvature = (index % 2 === 0 ? 1 : -1) * (Math.floor(index / 2) + 1) * 0.15 * edgeCount;
            }
            return curvature;
        }


        link.attr("d", function (d, i) {

            var route = colaLayout.routeEdge(d);


            // Get all edges between the two nodes, regardless of direction
            const allEdgesBetweenSourceAndTarget = edges.filter(edge => {
                return (edge.source.id == d.source.id && edge.target.id == d.target.id) ||
                    (edge.source.id == d.target.id && edge.target.id == d.source.id);
            });



            let n = d.id;
            // This is a special case for group edges
            if (n.startsWith("_g_")) {
                let source = d.source;
                let target = d.target;

                let sourceIndex = getNodeIndex(source.id);
                let targetIndex = getNodeIndex(target.id);

                // Depends on the source group and the target group.


                // This actually deals with subsumed groups, since only
                // the innermost group will include the element in its leaves.
                let targetGroup = groups.find(group => {
                    let leaves = group.leaves.map(leaf => leaf.id);
                    return leaves.includes(target.id);

                });

                let sourceGroup = groups.find(group => {
                    let leaves = group.leaves.map(leaf => leaf.id);
                    return leaves.includes(source.id);

                });

                const groupIsTarget = targetGroup && targetGroup.keyNode === sourceIndex;
                const groupIsSource = sourceGroup && sourceGroup.keyNode === targetIndex;

                if (groupIsSource && groupIsTarget) {
                    alert('Something is very wrong!');
                }


                // Only one of source group and target group can be a group.

                // Within source group, see if the target is the key

                function closestPointOnRect(bounds, point) {
                    // Destructure the rectangle bounds
                    const { x, y, X, Y } = bounds;

                    // Calculate the rectangle's edges
                    const left = x;
                    const right = X;
                    const top = y;
                    const bottom = Y;

                    // Clamp the point's coordinates to the rectangle's bounds
                    const closestX = Math.max(left, Math.min(point.x, right));
                    const closestY = Math.max(top, Math.min(point.y, bottom));

                    return { x: closestX, y: closestY };
                }




                if (groupIsTarget) {
                    let newTargetCoords = closestPointOnRect(targetGroup.bounds, route[0]);
                    let currentTarget = route[route.length - 1];
                    currentTarget.x = newTargetCoords.x;
                    currentTarget.y = newTargetCoords.y;


                }
                else if (groupIsSource) {
                    let newSourceCoords = closestPointOnRect(sourceGroup.bounds, route[route.length - 1]);
                    let currentSource = route[0];
                    currentSource.x = newSourceCoords.x;
                    currentSource.y = newSourceCoords.y;

                }
                else {
                    console.log("This is a group edge, but neither source nor target is a group.", d);
                }

                // Not ideal but we dont want odd curves.
                if (route.length > 2) {
                    route.splice(1, route.length - 2);
                }


            }




            // If there are only two points in the route, get the midpoint of the route and add it to the route
            if (route.length === 2) {
                const midpoint = {
                    x: (route[0].x + route[1].x) / 2,
                    y: (route[0].y + route[1].y) / 2
                };
                route.splice(1, 0, midpoint);
            }




            // Determine the direction of the edge
            var dx = route[1].x - route[0].x;
            var dy = route[1].y - route[0].y;
            var angle = Math.atan2(dy, dx);
            var distance = Math.sqrt(dx * dx + dy * dy);



            /** Here, we do some point of incidence adjustment IF the number of edges between the same nodes is greater than 1 */
            if (allEdgesBetweenSourceAndTarget.length > 1) {
                const minDistance = 10; // Minimum distance between edges (divided by 2)
                const edgeIndex = allEdgesBetweenSourceAndTarget.findIndex(edge => edge.id === d.id);

                // Start with a small offset and grow it based on the edge index. But start with min offset of 5
                const offset = (edgeIndex % 2 === 0 ? 1 : -1) * (Math.floor(edgeIndex / 2) + 1) * minDistance;

                // Now we should apply the offset to the start and end points of the route, depending on the angle.

                if (route.length > 1) {
                    const startIndex = 0;
                    const endIndex = route.length - 1;

                    /*
                    
                    Angle 0: The edge is horizontal and points to the right.
                    Angle π/2 (90 degrees): The edge is vertical and points upwards.
                    Angle π (180 degrees): The edge is horizontal and points to the left.
                    Angle -π/2 (-90 degrees): The edge is vertical and points downwards.
                    */
                    function getDominantDirection(angle) {
                        // Normalize angle between -π and π
                        angle = ((angle + Math.PI) % (2 * Math.PI)) - Math.PI;

                        if (angle >= -Math.PI / 4 && angle <= Math.PI / 4) {
                            return 'right'; // Dominant direction is right
                        } else if (angle > Math.PI / 4 && angle < 3 * Math.PI / 4) {
                            return 'up'; // Dominant direction is up
                        } else if (angle >= 3 * Math.PI / 4 || angle <= -3 * Math.PI / 4) {
                            return 'left'; // Dominant direction is left
                        } else if (angle > -3 * Math.PI / 4 && angle < -Math.PI / 4) {
                            return 'down'; // Dominant direction is down
                        }
                        return null; // Default to null if something unexpected happens
                    }
                    let direction = getDominantDirection(angle);


                    // As a result, offset along the y axis.
                    if (direction === 'right' || direction === 'left') {
                        route[startIndex].y += offset;
                        route[endIndex].y += offset;
                    }
                    // else if direction is up or down, offset along the x axis
                    else if (direction === 'up' || direction === 'down') {
                        route[startIndex].x += offset;
                        route[endIndex].x += offset;
                    }

                    // Ignore the other directions, if they do crop up.

                    // And ensure it stays on the rectangle perimeter
                    console.log("Adjusting points to rectangle perimeter");
                    route[startIndex] = adjustPointToRectanglePerimeter(route[startIndex], d.source.innerBounds);
                    route[endIndex] = adjustPointToRectanglePerimeter(route[endIndex], d.target.innerBounds);
                }

            }


            // Calculate the curvature for the current edge
            var curvature = calculateCurvature(edges, d.source.id, d.target.id, d.id);
            //Apply curvature to the control points (but this does not help with the direction)
            route.forEach(function (point, index) {


                if (index > 0 && index < route.length - 1 && curvature !== 0) {

                    // Adjust the control points based on the direction
                    var offsetX = curvature * Math.abs(Math.sin(angle)) * distance;
                    var offsetY = curvature * Math.abs(Math.cos(angle)) * distance;

                    point.x += offsetX;
                    point.y += offsetY;
                }
            });

            return lineFunction(route);
        });


        // Function to check for overlap
        function isOverlapping(label1, label2) {
            const bbox1 = label1.getBBox();
            const bbox2 = label2.getBBox();
            return !(bbox2.x > bbox1.x + bbox1.width ||
                    bbox2.x + bbox2.width < bbox1.x ||
                    bbox2.y > bbox1.y + bbox1.height ||
                    bbox2.y + bbox2.height < bbox1.y);
        }


        // Update label positions after routing edges
        linkGroups.select("text.linklabel")
            .attr("x", function (d) {
                const pathElement = document.querySelector(`path[data-link-id="${d.id}"]`);
                const pathLength = pathElement.getTotalLength();
                const midpoint = pathElement.getPointAtLength(pathLength / 2);
                return midpoint.x;
            })
            .attr("y", function (d) {
                const pathElement = document.querySelector(`path[data-link-id="${d.id}"]`);
                const pathLength = pathElement.getTotalLength();
                const midpoint = pathElement.getPointAtLength(pathLength / 2);
                return midpoint.y;
            })
            .attr("text-anchor", "end")
            .each(function(d, i, nodes) {
                const currentLabel = this;
                let overlap = false;
                d3.selectAll("text.linklabel").each(function() {
                    if (this !== currentLabel && isOverlapping(currentLabel, this)) {
                        overlap = true;
                    }
                });
                if (overlap) {
                    d3.select(this)
                        .attr("text-anchor", "start")
                        .attr("dx", 2); // Adjust the position to avoid overlap
                }
            })
            .raise();

        /**** This bit ensures we zoom to fit ***/
        const bbox = svg.node().getBBox();
        const padding = 10; // Padding in pixels

        const viewBox = [
            bbox.x - padding,
            bbox.y - padding,
            bbox.width + 2 * padding,
            bbox.height + 2 * padding
        ].join(' ');


        const topSvg = d3.select("#svg");
        topSvg.attr('viewBox', viewBox);
        /*************************************/

        linkGroups.on("mouseover", function (d) {
            const relName = d.relName;
            d3.selectAll(".link")
                .filter(link => link.relName === relName)
                .classed("highlighted", true);
            })
            .on("mouseout", function(event, d) {
                console.log("Mouse out");
                const relName = d.relName;
                d3.selectAll(".link")
                    .classed("highlighted", false);

                
            });
    };


    const linkGroups = svg.selectAll(".link-group")
        .data(edges)
        .enter()
        .append("g")
        .attr("class", "link-group");

    const link = linkGroups.append("path")
        .attr("class", "link")
        .attr("data-link-id", d => d.id);

    linkGroups.append("text")
        .attr("class", "linklabel")
        .text(d => d.relName);


    function isHiddenNode(node) {
        return node.name.startsWith("_");
    }



    var node = svg.selectAll(".node")
        .data(nodes)
        .enter().append("g") // Create a group for each node
        .attr("class", "node")
        .call(colaLayout.drag);

    node.append("rect")
        .attr("width", function (d) { return d.width; })
        .attr("height", function (d) { return d.height; }) // Use node's height
        .attr("x", function (d) { return -d.width / 2; }) // Center the rectangle on the node's x
        .attr("y", function (d) { return -d.height / 2; }) // Center the rectangle on the node's y
        .attr("stroke", function (d) { return d.color; }) // Outline color of the node
        .attr("stroke-width", 1.5) // Adjust the stroke width as needed
        .attr("fill", function (d) {
            let f = isHiddenNode(d) || (d.icon != null) ? "transparent" : "white";
            return f;
        });

    node.filter(d => d.icon) // Filter nodes that have an icon
        .append("image")
        .attr("xlink:href", d => d.icon)
        .attr("width", function (d) { return d.width * 0.8; }) // Scale down the icon to fit inside the rectangle
        .attr("height", function (d) { return d.height * 0.8; }) // Scale down the icon to fit inside the rectangle
        .attr("x", function (d) { return -d.width * 0.4; }) // Center the icon horizontally
        .attr("y", function (d) { return -d.height * 0.4; }); // Center the icon vertically




    var label = svg.selectAll(".label")
        .data(nodes)
        .enter().append("text")
        .attr("class", "label")
        .each(function (d) {

            if (isHiddenNode(d)) {
                return;
            }

            // Append tspan for d.name
            d3.select(this).append("tspan")
                .attr("x", 0) // Align with the parent text element
                .attr("dy", "0em") // Start at the same vertical position
                .style("font-weight", "bold")
                .text(d.name);

            var y = 1; // Start from the next line for attributes

            // Append tspans for each attribute
            for (let key in d.attributes) {
                d3.select(this).append("tspan")
                    .attr("x", 0) // Align with the parent text element
                    .attr("dy", `${y}em`) // Move each attribute to a new line
                    .text(key + ": " + d.attributes[key]);
                y += 1; // Increment for the next line
            }
        })
        .call(colaLayout.drag);


    // Helper function to calculate new position along the path
    function calculateNewPosition(previousPosition, pathElement, axis) {
        const pathLength = pathElement.getTotalLength();
        const midpointLength = pathLength / 2;
        const offset = getRandomOffsetAlongPath();

        let targetLength = midpointLength + offset;

        if (targetLength >= pathLength) {
            targetLength = midpointLength;
        }

        const point = pathElement.getPointAtLength(targetLength);
        return axis === 'x' ? point.x : point.y;
    }

    node.append("title")
        .text(function (d) { return d.name; });


    // Add a rectangle for each group and a label at the top of the group

    var group = svg.selectAll(".group")
        .data(groups)
        .enter().append("rect")
        .attr("class", "group")
        .attr("rx", 8).attr("ry", 8)
        .style("fill", function (d, i) {
            var targetNode = nodes[d.keyNode];
            return targetNode.color;
        })
        .attr("fill-opacity", 0.3)
        .call(colaLayout.drag);

    // TODO: Uncomment to reenable group labels
    var groupLabel = svg.selectAll(".groupLabel")
        .data(groups)
        .enter().append("text")
        .attr("class", "groupLabel")
        .text(function (d) {
            // TODO: Added this
            return "";
            //return d.name; 
        })
        .call(colaLayout.drag);

    colaLayout.on("tick", function () {

        group.attr("x", function (d) {
            return d.bounds.x;
        })
            .attr("y", function (d) {
                return d.bounds.y;
            })

            .attr("width", function (d) { return d.bounds.width(); })
            .attr("height", function (d) { return d.bounds.height(); })
            .lower();


        node.select("rect")
            .each(function (d) { d.innerBounds = d.bounds.inflate(-1); })
            .attr("x", function (d) { return d.bounds.x; })
            .attr("y", function (d) { return d.bounds.y; })
            .attr("width", function (d) { return d.bounds.width(); })
            .attr("height", function (d) { return d.bounds.height(); });

        node.select("image")
            .attr("x", function (d) { return d.bounds.x; })
            .attr("y", function (d) { return d.bounds.y; });




        label
            .attr("x", d => d.x)
            .attr("y", d => d.y)
            .each(function (d) {
                var y = 0; // Initialize y offset for tspans
                d3.select(this).selectAll("tspan")
                    .attr("x", d.x) // Align tspans with the node's x position
                    .attr("dy", function () {
                        y += 1; // Increment y for each tspan to create line spacing
                        return y === 1 ? "0em" : "1em"; // Keep the first tspan in place, move others down
                    });
            })
            .raise();


        linkGroups.select("path.link")
            .attr("d", function (d) {

                let source = d.source;
                let target = d.target;

                let n = d.id;
                if (n.startsWith("_g_")) {
                    // This actually deals with subsumed groups, since only
                    // the innermost group will include the element in its leaves.
                    let targetGroup = groups.find(group => {
                        let leaves = group.leaves.map(leaf => leaf.id);
                        return leaves.includes(target.id);

                    });
                    target = targetGroup;
                    target.innerBounds = target.bounds.inflate(-1);

                }


                var route = cola.makeEdgeBetween(source.innerBounds, target.innerBounds, 5);
                return lineFunction([route.sourceIntersection, route.arrowStart]);
            })
            .attr("marker-end", "url(#end-arrow)") // Ensure the marker-end attribute is set
            .raise(); // Raise the path to the top

        linkGroups.select("text.linklabel")
            .attr("x", d => {
                const pathElement = document.querySelector(`path[data-link-id="${d.id}"]`);
                return calculateNewPosition(d.x, pathElement, 'x');
            })
            .attr("y", d => {
                const pathElement = document.querySelector(`path[data-link-id="${d.id}"]`);
                return calculateNewPosition(d.y, pathElement, 'y');
            })
            .raise();




        groupLabel.attr("x", function (d) {
            return d.bounds.x + d.bounds.width() / 2;

        }) // Center horizontally
            .attr("y", function (d) { return d.bounds.y + 12; })
            .attr("text-anchor", "middle") // Center the text on its position
            .lower();


        linkGroups.select("text.linklabel").raise();

        // Can we get all end-arrow markers and raise them?
        svg.selectAll("marker").raise();


        linkGroups.select("text.linklabel").raise(); // Ensure link labels are raised

    });

    colaLayout.start(
        initialUnconstrainedIterations,
        initialUserConstraintIterations,
        initialAllConstraintsIterations,
        gridSnapIterations)
        .on("end", routeEdges);
}