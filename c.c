int a();
int b();

__attribute__((visibility("default"))) int testWasm() {
    return a() + b();
}
