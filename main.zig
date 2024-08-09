const std = @import("std");

fn main() !void {
    // start by reading a file I guess

    // TODO: file name input

    const file = try std.fs.cwd().readFile("weather.csv", .{.read_only});
    defer file.close();

    const stat = try file.stat();

    var buffer: [stat.size]u8 = undefined;
    var fixed_buffer_alloc = std.heap.FixedBufferAllocator.init(&buffer);
    var list = std.ArrayList(u32).init(fixed_buffer_alloc.allocator());
    defer list.deinit();

    std.debug.print("List: {any}\n", .{list.items});
}
