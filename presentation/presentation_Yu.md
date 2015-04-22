
---

title: "Final Project Presentation - network and clustering"
author: "Yu Tian"
date: "Thursday, April 23, 2015"
output: html_document
layout: post
description: Final Project

---


Learn about Yelp Users and Businesses
--------

# Overview
**Yelp user:**

* Overall Network
* Ego Network

**Yelp business:**

* Hierarchical Clustering


# I. People on Yelp

Notes: check out R package [igragh](http://igraph.org/)

See [My code](https://github.com/YuTian9/DV_NYDine/blob/master/Networks.Rmd) for network analysis and visualization.

##  1.1 Overall Network

This is a network of 87 yelp users, where everybody is connected to at least 4 of the others.

Download original data from [Yelp's Academic Dataset website] (https://www.yelp.com/academic_dataset). 

Information about 366715 yelp users can be found in the contained .json file "yelp_academic_dataset__user.json".

Information includes: 

1) **user's yelp id;**

2) **user's name;** 

3) **yelping_since:** since which year the user started using yelp, the original data has this variable coded as "yyyy-mm", here I only extracted the "year" ("yyyy"), and it ranges from 2004 to 2011;

4) **review_count:** the count for reviews the user wrote for all businesses;

5) **votes:** count for votes the user received across all his/her reviews; I am counting the aggregate votes for "funny", "useful" and "cool" altogether.

6) **compliments:** count for compliment the user received from other users;  

7) **average_stars:** average value of "stars" the user gave to all restaurants, ranges from 1 to 5; 

8) **fans:** number of fans the user have. Fans are people who follow the user but are not followed back by the user; 

9) **friends:** who is the user befriend with 

### 1.1.1 Network Density

0.1363272

### 1.1.2 Ugly Network Representation... 

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_v0.png" width="500" height="400">


### 1.1.3 Do better? 
**A. Add Some Attributes**

Do it in R:

    # shape: earlier than 2006 as "circle", later as "rectangle"
    V(g)[V(g)$yelping_since<2006]$shape <- "circle"
    V(g)[V(g)$yelping_since>2005]$shape <- "square"

    # color: 
    V(g)[V(g)$compliments<500]$color <- "black"
    V(g)[V(g)$compliments>500]$color <- "red"

    # size: num of fans
    V(g)$size <- sqrt(V(g)$fans)/2
    
    # lable size: average star
    V(g)$label.cex <- 2^(V(g)$average_stars)/15


<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_withattributes_v4.png" width="500" height="400">


**B. Use Other Layout**

* Random Layout:

Nodes are randomly located.

    plot(g,layout=layout.random)


<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_random_v5.png" width="500" height="400">


* Circle Layout

places the vertices on a unit circle equidistantly. It has no paramaters.


    plot(g,layout=layout.circle)


<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_circle_v7.png" width="500" height="400"> 


* Sphere Layout
    
places the vertices (approximately) uniformly on the surface of a sphere, this is thus a 3d layout. 

    plot(g,layout=layout.sphere)

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_sphere_v8.png" width="500" height="400">


* Fruchterman Reingold Layout:

Their purpose is to position the nodes of a graph in two-dimensional or three-dimensional space so that all the
edges are of more or less equal length and there are as few crossing edges as possible, by assigning forces among
the set of edges and the set of nodes, based on their relative positions, and then using these forces either to
simulate the motion of the edges and nodes or to minimize their energy.


    plot(g,layout=layout.fruchterman.reingold)


<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_FruchtermanReingold_v9.png" width="500" height="400">




**C. Community Structure in Networks**

Communities are dense subgraphs in directed or undirected graphs.

* edge betweenness communities:
    
edge betweenness score: measures the number of shortest paths through it.

Modules which are densely connected themselves but sparsely connected to other modules.

    eb <- edge.betweenness.community (adj_mtx_g, directed = F, edge.betweenness = TRUE, merges = TRUE,bridges=TRUE,modularity=TRUE,membership=TRUE) 
    plot(eb,adj_mtx_g)

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_betweenness_v1.png" width="500" height="400">

* walktrap communities:

Communities in a graph via random walks. The idea is that short random walks tend to stay in the same community.

    wt<-walktrap.community(adj_mtx_g,steps=200,modularity=TRUE)#,labels=TRUE) ##run random walk partitioning
    plot(wt,adj_mtx_g) ##plotR-Wpartitioning 

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_walktrap_v2.png" width="500" height="400">

* label propagation communities:

An effective method for community detection in large-scale complex networks.

IT works by labeling the vertices with unique labels and then updating the labels by majority voting in the neighborhood of the vertex.

    lp=label.propagation.community(adj_mtx_g) ##runlabelpropogationpartitioning 
    plot(lp,adj_mtx_g) ##plotL-Ppartitioning

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_propagation_v3.png" width="500" height="400">


##  1.2 Ego Network

### 1.2.1 Centrality Measures


1) **Degree Centrality**

Historically first and conceptually simplest is degree centrality, which is defined as the number of links
incident upon a node.

The degree can be interpreted in terms of the immediate risk of a node for catching whatever is flowing through
the network (such as a virus, or some information).
 
2) **Betweennesee Centrality**

Betweenness centrality quantifies the number of times a node acts as a bridge along the shortest path between two
other nodes. It was introduced as a measure for quantifying the control of a human on the communication between
other humans in a social network by Linton Freeman.

3) **Closeness Centrality**

Distance with other nodes in the network.

4) **Eigenvector Centrality**

A measure of the influence of a node in a network. 

It assigns relative scores to all nodes in the network based on the concept that connections to high-scoring nodes 
contribute more to the score of the node in question than equal connections to low-scoring nodes. (Google's 
PageRank )

    # measures on egos
    degree <- degree(adj_mtx_g, loops=T, normalized=T)
    btwn <- betweenness(adj_mtx_g, directed = F,normalized=T)
    close <- closeness(adj_mtx_g, mode = c("all"),normalized=T)
    eigen <- evcent(adj_mtx_g,directed = F)


### 1.2.1 Covariances between centrality measures

* Covariances Matrix

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/Covariance_Matrix.png" width="600" height="200">



### 1.2.2 Centrality measures and Attributes

* Degree Measures with Attributes

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/matrices_degree.png" width="600" height="400">

* Betweenness Measures with Attributes

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/matrices_betweenness.png" width="600" height="400">


* Closeness Measures with Attributes

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/matrices_closeness.png" width="600" height="400">


* Eigenvector Measures with Attributes


<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/matrices_eigenvector.png" width="600" height="400">

* All Measures with Attributes

<img src="https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/matrices_all.png" width="600" height="400">

### 1.2.3 Regression Results

* degree ~ yelping_since + votes + fans


* betweenness ~  fans + yelping_since + votes + compliments


* closeness ~ votes  + fans +yelping_since+ review_count + compliments


* eigenvector ~ fans +yelping_since+ votes + review_count + compliments



# II. Businesses on Yelp

##  2.1 Hierarchical Clustering

