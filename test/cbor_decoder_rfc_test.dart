/*
 * Package : Cbor
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/12/2016
 * Copyright :  S.Hamblett
 */
import 'package:typed_data/typed_data.dart' as typed;
import 'package:cbor/cbor.dart' as cbor;
import 'package:test/test.dart';
import 'cbor_test_listener.dart';

void main() {
  group('RFC Appendix A Diagnostics decoder tests -> ', () {
    // Common initialisation
    final output = cbor.OutputStandard();
    final listener = ListenerTest();
    final slistener = cbor.ListenerStack();

    test('0', () {
      output.clear();
      listener.clear();
      final values = [0x0];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [0]);
      decoder.listener = slistener;
      input.reset();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 0);
    });

    test('1', () {
      output.clear();
      listener.clear();
      final values = [0x1];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1);
    });

    test('10', () {
      output.clear();
      listener.clear();
      final values = [0x0a];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [10]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 10);
    });

    test('23', () {
      output.clear();
      listener.clear();
      final values = [0x17];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [23]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 23);
    });

    test('24', () {
      output.clear();
      listener.clear();
      final values = [0x18, 0x18];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [24]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 24);
    });

    test('25', () {
      output.clear();
      listener.clear();
      final values = [0x18, 0x19];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [25]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 25);
    });

    test('100', () {
      output.clear();
      listener.clear();
      final values = [0x18, 0x64];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [100]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 100);
    });

    test('1000', () {
      output.clear();
      listener.clear();
      final values = [0x19, 0x03, 0xe8];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1000]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1000);
    });

    test('1000000', () {
      output.clear();
      listener.clear();
      final values = [0x1a, 0x00, 0x0f, 0x42, 0x40];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      slistener.itemStack.clear();
      expect(listener.lastValue, [1000000]);
      decoder.listener = slistener;
      input.reset();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1000000);
    });

    test('1000000000000', () {
      output.clear();
      listener.clear();
      final values = [0x1b, 0x00, 0x00, 0x00, 0xe8, 0xd4, 0xa5, 0x10, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1000000000000]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1000000000000);
    });

    test('18446744073709551615', () {
      output.clear();
      listener.clear();
      final values = [0x1b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      final temp = BigInt.parse('18446744073709551615').toSigned(64);
      expect(BigInt.from(listener.lastValue[0]).compareTo(temp), 0);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(BigInt.from(slist[0].data).compareTo(temp), 0);
    });

    test('18446744073709551616', () {
      output.clear();
      listener.clear();
      final values = <int>[
        0xc2,
        0x49,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        2,
        [1, 0, 0, 0, 0, 0, 0, 0, 0]
      ]);
      expect(listener.lastTag, 2);
      expect(listener.lastByteCount, 9);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      final temp = BigInt.parse('18446744073709551616').toSigned(64);
      expect(slist[0].data.toSigned(64).compareTo(temp), 0);
    });

    test('-18446744073709551616', () {
      output.clear();
      listener.clear();
      final values = [0x3b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      final temp = BigInt.parse('-18446744073709551616').toSigned(64);
      expect(BigInt.from(listener.lastValue[0]).compareTo(temp), 0);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(BigInt.zero.compareTo(temp), 0);
    });

    test('18446744073709551617', () {
      output.clear();
      listener.clear();
      final values = [
        0xc3,
        0x49,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        3,
        [1, 0, 0, 0, 0, 0, 0, 0, 0]
      ]);
      expect(listener.lastTag, 3);
      expect(listener.lastByteCount, 9);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      final temp = BigInt.parse('18446744073709551617').toSigned(64);
      expect(slist[0].data.toSigned(64).compareTo(temp), 0);
    });

    test('-1', () {
      output.clear();
      listener.clear();
      final values = [0x20];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-1]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -1);
    });

    test('-10', () {
      output.clear();
      listener.clear();
      final values = [0x29];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-10]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -10);
    });

    test('-100', () {
      output.clear();
      listener.clear();
      final values = [0x38, 0x63];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-100]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -100);
    });

    test('-1000', () {
      output.clear();
      listener.clear();
      final values = [0x39, 0x3, 0xe7];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-1000]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -1000);
    });

    test('0.0', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [0.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 0.0);
    });

    test('-0.0', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x80, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-0.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -0.0);
    });

    test('1.0', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x3c, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1.0);
    });

    test('1.1', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0x3f, 0xf1, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1.1]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1.1);
    });

    test('1.5', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x3e, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1.5]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1.5);
    });

    test('65504.0', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x7b, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [65504.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 65504.0);
    });

    test('100000.0', () {
      output.clear();
      listener.clear();
      final values = [0xfa, 0x47, 0xc3, 0x50, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [100000.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 100000.0);
    });

    test('3.4028234663852886e+38', () {
      output.clear();
      listener.clear();
      final values = [0xfa, 0x7f, 0x7f, 0xff, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [3.4028234663852886e+38]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 3.4028234663852886e+38);
    });

    test('1.0e+300', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0x7e, 0x37, 0xe4, 0x3c, 0x88, 0x00, 0x75, 0x9c];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1.0e+300]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1.0e+300);
    });

    test('5.960464477539063e-8', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x00, 0x01];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [5.960464477539063e-8]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 5.960464477539063e-8);
    });

    test('0.00006103515625', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x04, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [0.00006103515625]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 0.00006103515625);
    });

    test('-4.0', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0xc4, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-4.0]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -4.0);
    });

    test('-4.1', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0xc0, 0x10, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-4.1]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -4.1);
    });

    test('Infinity half', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x7c, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, double.infinity);
    });

    test('NaN half', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0x7e, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue[0], isNaN);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, isNaN);
    });

    test('-Infinity half', () {
      output.clear();
      listener.clear();
      final values = [0xf9, 0xfc, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -double.infinity);
    });

    test('Infinity single', () {
      output.clear();
      listener.clear();
      final values = [0xfa, 0x7f, 0x80, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, double.infinity);
    });

    test('NaN single', () {
      output.clear();
      listener.clear();
      final values = [0xfa, 0x7f, 0xc0, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue[0], isNaN);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, isNaN);
    });

    test('-Infinity single', () {
      output.clear();
      listener.clear();
      final values = [
        0xfa,
        0xff,
        0x80,
        0x00,
        0x00,
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -double.infinity);
    });

    test('Infinity double', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0x7f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, double.infinity);
    });

    test('NaN double', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0x7f, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue[0], isNaN);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, isNaN);
    });

    test('-Infinity double', () {
      output.clear();
      listener.clear();
      final values = [0xfb, 0xff, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [-double.infinity]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, -double.infinity);
    });

    test('false', () {
      output.clear();
      listener.clear();
      final values = [0xf4];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [false]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, false);
    });

    test('true', () {
      output.clear();
      listener.clear();
      final values = [0xf5];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [true]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, true);
    });

    test('null', () {
      output.clear();
      listener.clear();
      final values = [0xf6];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue[0], isNull);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, null);
    });

    test('undefined', () {
      output.clear();
      listener.clear();
      final values = [0xf7];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['Undefined']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, null);
    });

    test('Simple(16)', () {
      output.clear();
      listener.clear();
      final values = [0xf0];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [16]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 16);
    });

    test('Simple(24)', () {
      output.clear();
      listener.clear();
      final values = [0xf8, 0x18];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [24]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 24);
    });

    test('Simple(255)', () {
      output.clear();
      listener.clear();
      final values = [0xf8, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [255]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 255);
    });

    test('Tag (0) Date Time', () {
      output.clear();
      listener.clear();
      final values = [
        0xc0,
        0x74,
        0x32,
        0x30,
        0x31,
        0x33,
        0x2d,
        0x30,
        0x33,
        0x2d,
        0x32,
        0x31,
        0x54,
        0x32,
        0x30,
        0x3a,
        0x30,
        0x34,
        0x3a,
        0x30,
        0x30,
        0x5a
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [0, '2013-03-21T20:04:00Z']);
      expect(listener.lastTag, 0);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, '2013-03-21T20:04:00Z');
    });

    test('Tag (1) Int', () {
      output.clear();
      listener.clear();
      final values = [0xc1, 0x1a, 0x51, 0x4b, 0x67, 0xb0];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 1363896240]);
      expect(listener.lastTag, 1);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1363896240);
    });

    test('Tag (1) Float', () {
      output.clear();
      listener.clear();
      final values = [
        0xc1,
        0xfb,
        0x41,
        0xd4,
        0x52,
        0xd9,
        0xec,
        0x20,
        0x00,
        0x00
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 1363896240.5]);
      expect(listener.lastTag, 1);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final slist = slistener.itemStack.walk();
      expect(slist.length, 1);
      expect(slist[0].data, 1363896240.5);
    });

    test('Tag (23) multiple', () {
      output.clear();
      listener.clear();
      final values = [0xd7, 0x44, 0x01, 0x02, 0x03, 0x04];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        23,
        [1, 2, 3, 4]
      ]);
      expect(listener.lastTag, 23);
      expect(listener.lastByteCount, 4);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [1, 2, 3, 4]);
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.base16);
    });

    test('Tag (24) multiple', () {
      output.clear();
      listener.clear();
      final values = [0xd8, 0x18, 0x45, 0x64, 0x49, 0x45, 0x54, 0x46];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        24,
        [100, 73, 69, 84, 70]
      ]);
      expect(listener.lastByteCount, 5);
      expect(listener.lastTag, 24);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [100, 73, 69, 84, 70]);
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.encodedCBOR);
    });

    test('Tag (32) URI', () {
      output.clear();
      listener.clear();
      final values = [
        0xd8,
        0x20,
        0x76,
        0x68,
        0x74,
        0x74,
        0x70,
        0x3a,
        0x2f,
        0x2f,
        0x77,
        0x77,
        0x77,
        0x2e,
        0x65,
        0x78,
        0x61,
        0x6d,
        0x70,
        0x6c,
        0x65,
        0x2e,
        0x63,
        0x6f,
        0x6d
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [32, 'http://www.example.com']);
      expect(listener.lastTag, 32);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], 'http://www.example.com');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.uri);
    });

    test('Empty single quotes', () {
      output.clear();
      listener.clear();
      final values = [0x40];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [[]]);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], []);
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('4 bytes', () {
      output.clear();
      listener.clear();
      final values = [0x44, 0x01, 0x02, 0x03, 0x04];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        [01, 02, 03, 04]
      ]);
      expect(listener.lastByteCount, 4);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [01, 02, 03, 04]);
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Empty double quotes', () {
      output.clear();
      listener.clear();
      final values = [0x60];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], '');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('a', () {
      output.clear();
      listener.clear();
      final values = [0x61, 0x61];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['a']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], 'a');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('IETF', () {
      output.clear();
      listener.clear();
      final values = [0x64, 0x49, 0x45, 0x54, 0x46];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['IETF']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], 'IETF');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Quoted backslash', () {
      output.clear();
      listener.clear();
      final values = [0x62, 0x22, 0x5c];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['\"\\']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], '\"\\');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Unicode ü', () {
      output.clear();
      listener.clear();
      final values = [0x62, 0xc3, 0xbc];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['ü']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], 'ü');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Unicode 水', () {
      output.clear();
      listener.clear();
      final values = [0x63, 0xe6, 0xb0, 0xb4];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['水']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], '水');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Unicode 𐅑', () {
      output.clear();
      listener.clear();
      final values = [0x64, 0xf0, 0x90, 0x85, 0x91];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['𐅑']);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], '𐅑');
      final item = slistener.itemStack.peek();
      expect(item.hint, cbor.dataHints.none);
    });

    test('Array empty', () {
      output.clear();
      listener.clear();
      final values = [0x80];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastSize, 0);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], []);
    });

    test('Array 1,2,3', () {
      output.clear();
      listener.clear();
      final values = [0x83, 0x01, 0x02, 0x03];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3]);
      expect(listener.lastSize, 3);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [1, 2, 3]);
    });

    test('Array 1,2,3...25', () {
      output.clear();
      listener.clear();
      final values = [
        0x98,
        0x19,
        0x01,
        0x02,
        0x03,
        0x04,
        0x05,
        0x06,
        0x07,
        0x08,
        0x09,
        0x0a,
        0x0b,
        0x0c,
        0x0d,
        0x0e,
        0x0f,
        0x10,
        0x11,
        0x12,
        0x13,
        0x14,
        0x15,
        0x16,
        0x17,
        0x18,
        0x18,
        0x18,
        0x19
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25
      ]);
      expect(listener.lastSize, 25);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25
      ]);
    });

    test('Nested array', () {
      output.clear();
      listener.clear();
      final values = [0x83, 0x01, 0x82, 0x02, 0x03, 0x82, 0x04, 0x05];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4, 5]);
      expect(listener.lastSize, 2);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        [2, 3],
        [4, 5]
      ]);
    });

    test('Empty Map', () {
      output.clear();
      listener.clear();
      final values = [0xa0];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, []);
      expect(listener.lastSize, 0);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {});
    });

    test('{1: 2, 3: 4}', () {
      output.clear();
      listener.clear();
      final values = [0xa2, 0x01, 0x02, 0x03, 0x04];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4]);
      expect(listener.lastSize, 2);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {1: 2, 3: 4});
    });

    test('{"a": 1, "b": [2, 3]}', () {
      output.clear();
      listener.clear();
      final values = [0xa2, 0x61, 0x61, 0x01, 0x61, 0x62, 0x82, 0x02, 0x03];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['a', 1, 'b', 2, 3]);
      expect(listener.lastSize, 2);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {
        'a': 1,
        'b': [2, 3]
      });
    });

    test('["a", {"b": "c"}]', () {
      output.clear();
      listener.clear();
      final values = [0x82, 0x61, 0x61, 0xa1, 0x61, 0x62, 0x61, 0x63];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['a', 'b', 'c']);
      expect(listener.lastSize, 1);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        'a',
        {'b': 'c'}
      ]);
    });

    test('{"a": "A", "b": "B", "c": "C", "d": "D", "e": "E"}', () {
      output.clear();
      listener.clear();
      final values = [
        0xa5,
        0x61,
        0x61,
        0x61,
        0x41,
        0x61,
        0x62,
        0x61,
        0x42,
        0x61,
        0x63,
        0x61,
        0x43,
        0x61,
        0x64,
        0x61,
        0x44,
        0x61,
        0x65,
        0x61,
        0x45
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue,
          ['a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E']);
      expect(listener.lastSize, 5);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {'a': 'A', 'b': 'B', 'c': 'C', 'd': 'D', 'e': 'E'});
    });

    test("(_ h'0102', h'030405')", () {
      output.clear();
      listener.clear();
      final values = [0x5f, 0x42, 0x01, 0x02, 0x43, 0x03, 0x04, 0x05, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        [1, 2],
        [3, 4, 5]
      ]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [1, 2, 3, 4, 5]);
    });

    test('(_ "strea", "ming")', () {
      output.clear();
      listener.clear();
      final values = [
        0x7f,
        0x65,
        0x73,
        0x74,
        0x72,
        0x65,
        0x61,
        0x64,
        0x6d,
        0x69,
        0x6e,
        0x67,
        0xff
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['strea', 'ming']);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], 'streaming');
    });

    test('[_ ]', () {
      output.clear();
      listener.clear();
      final values = [0x9f, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, []);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], []);
    });

    test('[_ 1, [2, 3], [_4, 5]]', () {
      output.clear();
      listener.clear();
      final values = [
        0x9f,
        0x01,
        0x82,
        0x02,
        0x03,
        0x9f,
        0x04,
        0x05,
        0xff,
        0xff
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4, 5]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        [2, 3],
        [4, 5]
      ]);
    });

    test('[_ 1, [2, 3], [4, 5]]', () {
      output.clear();
      listener.clear();
      final values = [0x9f, 0x01, 0x82, 0x02, 0x03, 0x82, 0x04, 0x05, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4, 5]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        [2, 3],
        [4, 5]
      ]);
    });

    test('[1, [2, 3], [_ 4, 5]]', () {
      output.clear();
      listener.clear();
      final values = [0x83, 0x01, 0x82, 0x02, 0x03, 0x9f, 0x04, 0x05, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4, 5]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        [2, 3],
        [4, 5]
      ]);
    });

    test('[1, [_ 2, 3], [4, 5]]', () {
      output.clear();
      listener.clear();
      final values = [0x83, 0x01, 0x9f, 0x02, 0x03, 0xff, 0x82, 0x04, 0x05];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [1, 2, 3, 4, 5]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        [2, 3],
        [4, 5]
      ]);
    });

    test('[_ 1, 2, 3 .. 25]', () {
      output.clear();
      listener.clear();
      final values = [
        0x9f,
        0x01,
        0x02,
        0x03,
        0x04,
        0x05,
        0x06,
        0x07,
        0x08,
        0x09,
        0x0a,
        0x0b,
        0x0c,
        0x0d,
        0x0e,
        0x0f,
        0x10,
        0x11,
        0x12,
        0x13,
        0x14,
        0x15,
        0x16,
        0x17,
        0x18,
        0x18,
        0x18,
        0x19,
        0xff
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25
      ]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25
      ]);
    });

    test('{_ "a":1, "b": [_ 2,3]}', () {
      output.clear();
      listener.clear();
      final values = [
        0xbf,
        0x61,
        0x61,
        0x01,
        0x61,
        0x62,
        0x9f,
        0x02,
        0x03,
        0xff,
        0xff
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['a', 1, 'b', 2, 3]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {
        'a': 1,
        'b': [2, 3]
      });
    });

    test('["a", {_ "b": "c"}]', () {
      output.clear();
      listener.clear();
      final values = [0x82, 0x61, 0x61, 0xbf, 0x61, 0x62, 0x61, 0x63, 0xff];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['a', 'b', 'c']);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], [
        'a',
        {'b': 'c'}
      ]);
    });

    test('{_ "Fun": true, "Amt": -2}', () {
      output.clear();
      listener.clear();
      final values = [
        0xbf,
        0x63,
        0x46,
        0x75,
        0x6e,
        0xf5,
        0x63,
        0x41,
        0x6d,
        0x74,
        0x21,
        0xff
      ];
      final buffer = typed.Uint8Buffer();
      buffer.addAll(values);
      output.putBytes(buffer);
      final input = cbor.Input(output.getData());
      final decoder = cbor.Decoder.withListener(input, listener);
      decoder.run();
      expect(listener.lastValue, ['Fun', true, 'Amt', -2]);
      expect(listener.indefiniteStart, isTrue);
      decoder.listener = slistener;
      input.reset();
      slistener.itemStack.clear();
      decoder.run();
      final decodeStack = cbor.DecodeStack();
      decodeStack.build(slistener.itemStack);
      final slist = decodeStack.walk();
      expect(slist.length, 1);
      expect(slist[0], {'Fun': true, 'Amt': -2});
    });
  });
}
