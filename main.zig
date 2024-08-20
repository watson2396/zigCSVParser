const std = @import("std");

pub fn main() !void {
    // start by reading a file I guess

    // TODO: cli file name input

    const file_path = "./weather.csv";

    var file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    const allocator = std.heap.page_allocator;

    const contents = try file.reader().readAllAlloc(
        allocator,
        try file.getEndPos(),
    );
    defer allocator.free(contents);

    std.debug.print("List: {any}\n", .{contents});
}
