const std = @import("std");

pub fn main() !void {
    // start by reading a file I guess

    // TODO: file name input

    //pub fn readFileAlloc(self: Dir, allocator: mem.Allocator, file_path: []const u8, max_bytes: usize) ![]u8
    const allocator = std.heap.page_allocator;
    var read_bytes = std.fs.cwd().readFileAlloc(allocator, "./weather.csv", 65535);
    defer read_bytes.deinit();

    std.debug.print("List: {any}\n", .{read_bytes.items});
}
