Learn about Yelp Users and Businesses
--------

# Overview
**Yelp user:**

    * Overall Network
    * Ego Network

**Yelp business:**

    * Hierarchical Clustering


# I. People on Yelp

Notes: check out R package {igragh} (http://igraph.org/)

##  1.1 Overall Network

This is a network of 87 yelp users, where everybody is connected to at least 4 of the others.

Download original data from [Yelp's Academic Dataset website] (https://www.yelp.com/academic_dataset). 

Information about 366715 yelp users can be found in the contained .json file "yelp_academic_dataset_user.json".

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

### - Network Density

[inset]

### - Ugly Network Representation... 

![network graph 1](https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_v0.png) 

### - Do better? 

**A. community structure in networks**

Community find dense subgraphs in directed or undirected graphs

*edge betweenness communities:
    
edge betweenness score: measures the number of shortest paths through it.

Modules which are densely connected themselves but sparsely connected to other modules.

![network graph 2](https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_betweenness_v1.png) 


*walktrap communities:

Communities in a graph via random walks. The idea is that short random walks tend to stay in the same community.

![network graph 3](https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_walktrap_v2.png) 


*label propagation communities:

An effective method for community detection in large-scale complex networks.

IT works by labeling the vertices with unique labels and then updating the labels by majority voting in the neighborhood of the vertex.

![network graph 4](https://raw.githubusercontent.com/YuTian9/DV_NYDine/master/fig/network_propagation_v3.png) 


##  1.2 Ego Network



# II. Businesses on Yelp

##  2.1 Hierarchical Clustering

