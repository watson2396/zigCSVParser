const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "zigCsvParser",
        .root_source_file = b.path("main.zig"),
        .target = b.host,
    });

    b.installArtifact(exe);
}
