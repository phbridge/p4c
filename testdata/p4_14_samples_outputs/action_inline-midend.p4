#include <core.p4>
#include <v1model.p4>

struct ht {
    bit<1> b;
}

struct metadata {
    @name("md") 
    ht md;
}

struct headers {
}

parser ParserImpl(packet_in packet, out headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    @name("start") state start {
        transition accept;
    }
}

control ingress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    @name("NoAction") action NoAction_0() {
    }
    @name("b") action b_0() {
        meta.md.b = meta.md.b + 1w1;
        meta.md.b = meta.md.b + 1w1;
    }
    @name("t") table t() {
        actions = {
            b_0();
            @default_only NoAction_0();
        }
        default_action = NoAction_0();
    }
    apply {
        t.apply();
    }
}

control egress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    apply {
    }
}

control DeparserImpl(packet_out packet, in headers hdr) {
    apply {
    }
}

control verifyChecksum(in headers hdr, inout metadata meta) {
    apply {
    }
}

control computeChecksum(inout headers hdr, inout metadata meta) {
    apply {
    }
}

V1Switch<headers, metadata>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;
