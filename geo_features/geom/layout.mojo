from math.limit import max_finite
from tensor import Tensor

alias Layout2 = Layout[2, DType.float64, DType.uint32]
alias Layout3 = Layout[3, DType.float64, DType.uint32]
alias Layout4 = Layout[4, DType.float64, DType.uint32]


@value
struct Layout[
    dims: Int = 2,
    coord_dtype: DType = DType.float64,
    offset_dtype: DType = DType.uint32,
]:
    """
    Memory layout inspired by, but not exactly following, the GeoArrow format.

    ### Parameters

    - `dims`: number of dimensions. Default: `2` for XY.
        Use `3` for XYZ (height) or XYM (measure), or `4` for XYZM (height and measure).
    - `coord_dtype`: data type of coordinates. Default: `DType.float64`, the standard for GEOS/GeoArrow interop.
        Use `DType.float32` for less memory usage.
    - `offset_dtype`: controls the maximum number of coordinates which can be stored in this layout.
        Default: `uint32` (can store very large features). Use an unsigned integer type here.

    ### Spec

    https://geoarrow.org
    """

    var coordinates: Tensor[coord_dtype]
    var geometry_offsets: Tensor[offset_dtype]
    var part_offsets: Tensor[offset_dtype]
    var ring_offsets: Tensor[offset_dtype]

    fn __init__(
        inout self, coords_size: Int, geoms_size: Int, parts_size: Int, rings_size: Int
    ):
        """
        Create column-oriented tensor: rows (dims) x cols (coords), and offsets vectors.
        """
        if max_finite[offset_dtype]() < coords_size:
            print(
                "Warning: offset_dtype parameter not large enough for coords_size arg.",
                offset_dtype,
                coords_size,
            )
        self.coordinates = Tensor[coord_dtype](dims, coords_size)
        self.geometry_offsets = Tensor[offset_dtype](geoms_size)
        self.part_offsets = Tensor[offset_dtype](parts_size)
        self.ring_offsets = Tensor[offset_dtype](rings_size)

    fn __eq__(self, other: Self) -> Bool:
        """
        Check equality of coordinates and offsets vs other.
        """
        if (
            self.coordinates == other.coordinates
            and self.geometry_offsets == other.geometry_offsets
            and self.part_offsets == other.part_offsets
            and self.ring_offsets == other.ring_offsets
        ):
            return True
        return False

    fn __ne__(self, other: Self) -> Bool:
        """
        Check in-equality of coordinates and offsets vs other.
        """
        return not self == other

    fn __len__(self) -> Int:
        """
        Length is the number of coordinates, and is the constructor's `coords_size` argument.
        """
        return self.coordinates.shape()[1]
