const std = @import("std");

const Builder = std.build.Builder;
const Mode = builtin.Mode;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const example_step = b.step("examples", "Build examples");
    inline for (.{
        "alternative_charset",
        "borders",
        "keys",
        "mouse",
        "printing",
        "windows",
    }) |name| {
        const example = b.addExecutable(name, "examples/" ++ name ++ ".zig");
        example.addPackagePath("ncurses", "lib.zig");
        example.setBuildMode(mode);
        example.setTarget(target);
        example.linkLibC();
        example.linkSystemLibrary("curses");
        example.install();
        example_step.dependOn(&example.step);
    }

    const all_step = b.step("all", "Build everything");
    all_step.dependOn(example_step);
    b.default_step.dependOn(all_step);
}
