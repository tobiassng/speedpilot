class OccupancyGrid {
  final Header header;
  final MapMetaData mapMetaData;
  final List<int> data;

  OccupancyGrid(
      {required this.header, required this.mapMetaData, required this.data});

  factory OccupancyGrid.fromJson(Map<String, dynamic> json) {
    List<int> dataIntList = (json["data"] as List<dynamic>)
        .map<int>((item) => item as int)
        .toList();

    return OccupancyGrid(
      header: Header(
        frameId: json["header"]["frame_id"],
        stamp: Stamp(
          sec: json["header"]["stamp"]["sec"],
          nanosec: json["header"]["stamp"]["nanosec"],
        ),
      ),
      mapMetaData: MapMetaData(
        resolution: json["info"]["resolution"],
        width: json["info"]["width"],
        height: json["info"]["height"],
        origin: Pose(
          position: Position(
            x: json["info"]["origin"]["position"]["x"],
            y: json["info"]["origin"]["position"]["y"],
            z: json["info"]["origin"]["position"]["z"],
          ),
          orientation: Orientation(
            x: json["info"]["origin"]["orientation"]["x"],
            y: json["info"]["origin"]["orientation"]["y"],
            z: json["info"]["origin"]["orientation"]["z"],
            w: json["info"]["origin"]["orientation"]["w"],
          ),
        ),
      ),
      data: dataIntList,
    );
  }
}

class Header {
  final String frameId;
  final Stamp stamp;

  Header({required this.frameId, required this.stamp});
}

class Stamp {
  final int sec;
  final int nanosec;

  Stamp({required this.sec, required this.nanosec});
}

class MapMetaData {
  final double resolution;
  final int width;
  final int height;
  final Pose origin;

  MapMetaData(
      {required this.resolution,
      required this.width,
      required this.height,
      required this.origin});
}

class Pose {
  final Position position;
  final Orientation orientation;

  Pose({required this.position, required this.orientation});
}

class Position {
  final double x, y, z;

  Position({required this.x, required this.y, required this.z});
}

class Orientation {
  final double x, y, z, w;

  Orientation(
      {required this.x, required this.y, required this.z, required this.w});
}
