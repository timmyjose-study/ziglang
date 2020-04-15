const Set1 = error{
    A,
    B,
};

const Set2 = error{
    A,
    C,
};

comptime {
    _ = @errSetCast(Set1, Set2.C);
}
