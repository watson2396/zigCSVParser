const std = @import("std");
const ascii = std.ascii;
const print = std.debug.print;

pub fn main() !void {
    // start by reading a file I guess
    // TODO: cli file name input
    const allocator = std.heap.page_allocator;

    var file = try std.fs.cwd().openFile("./weather.csv", .{});
    defer file.close();

    // TODO: decode file contents to understand CSV format
    // print out each line

    // Wrap the file reader in a buffered reader.
    // Since it's usually faster to read a bunch of bytes at once.
    var buf_reader = std.io.bufferedReader(file.reader());
    const reader = buf_reader.reader();

    var line = std.ArrayList(u8).init(allocator);
    defer line.deinit();

    const writer = line.writer();
    var line_no: usize = 0;
    // since while loop runs until a false condition and the fn
    // doesn't return a false value only error or void
    // the reader is run until the delimiter then the
    // while loop body is run then another loop starts
    // when the end of file is hit that is an error
    // which is handled by the else part
    while (reader.streamUntilDelimiter(writer, '\n', null)) {
        // Clear the line so we can reuse it.
        defer line.clearRetainingCapacity();
        line_no += 1;

        print("{d}--{s}\n", .{ line_no, line.items });
    } else |err| switch (err) {
        error.EndOfStream => { // end of file
            if (line.items.len > 0) {
                line_no += 1;
                print("{d}--{s}\n", .{ line_no, line.items });
            }
        },
        else => return err, // Propagate error
    }

    print("Total lines: {d}\n", .{line_no});

    // var line_buffer: [500]u8 = undefined;
    // var idx: u16 = 0;
    // for (contents) |character| {
    //     if (character == ascii.control_code.lf or character == ascii.control_code.cr) {
    //         std.debug.print("line: {d}\n", .{line_buffer});
    //         idx = 0;
    //         for (line_buffer, 0..) |_, i| {
    //             line_buffer[i] = 0;
    //         }
    //     } else {
    //         line_buffer[idx] = character;
    //         idx += idx;
    //     }
    // }
}
