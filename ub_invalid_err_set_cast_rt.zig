const Set1 = error{
    A,
    B,
};

const Set2 = error{
    A,
    C,
};

fn foo(e: Set1) void {
    const x = @errSetCast(Set2, e);
}

pub fn main() void {
    foo(Set1.B);
}
