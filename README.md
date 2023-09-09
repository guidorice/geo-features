# geo_features

Geographic and geometric vector features (Mojo package)

## design and architecture

`geo_features` is a native [Mojo](https://github.com/modularml/mojo) package for geographic or topological vector features, for example location data or
earth observation data. It is intended to be an alternative to the GEOS/Shapely package. It is guided by the
[GeoJSON](https://datatracker.ietf.org/doc/html/rfc7946) and [OGC Simple Features](https://www.ogc.org/standards/) specs.

## project goals

- Interoperate with the Python scientific computing ecosystem including NumPy, Pandas and the [Python array API
  standard](https://data-apis.org/array-api/latest).
- Promote cloud native geospatial formats, e.g.: object storage, COG, GeoParquet, GeoPackage, and Zarr.
- Promote value semantics, it is preferred over reference semantics.
- Promote vectorization (SIMD) and concurrency to the core.
- Benefit existing Python ecosystem wherever possible for convenience and rapid development (ex: a WKT parser).

## structs roadmap

- [ ] CoordinateSequence
- [ ] AdjacencyMatrix
- [ ] Position
- [ ] Point
- [ ] BoundingBox
- [ ] MultiPoint
- [ ] LineString
- [ ] MultiLineString
- [ ] Polygon
- [ ] MultiPolygon
- [ ] GeometryCollection
- [ ] Feature
- [ ] FeatureCollection

## methods roadmap

- [ ] area
- [ ] perimeter
- [ ] centroid
- [ ] intersection
- [ ] union
- [ ] difference

## algorithms roadmap

- [ ] parallelized/optimized spatial join
- [ ] rasterize from vector
- [ ] vectorize from raster
- [ ] projections and CRS support
- [ ] simplify or decimate
- [ ] stratified sampling
- [ ] smart antimeridian crossing mode? (dual quaternions?)

## architectural design

Features are composed of an N-dimensional arrays of numeric types, e.g (float32). If greater than 2 dimensions are
needed, there is flexibility in that they can represent an elevation (z) and/or other measurement dimensions (m1, m2,
...mn), for example.

Graphs of geometries within Features are composed of [adjacency
matrices](https://en.wikipedia.org/wiki/Adjacency_matrix) for memory and cache efficiency.
