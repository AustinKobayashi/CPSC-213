package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.omg.CORBA.DynAnyPackage.Invalid;


/**
 * Main Memory of Simple CPU.
 *
 * Provides an abstraction of main memory (DRAM).
 */

public class MainMemory extends AbstractMainMemory {
  private byte [] mem;
  
  /**
   * Allocate memory.
   * @param byteCapacity size of memory in bytes.
   */
  public MainMemory (int byteCapacity) {
    mem = new byte [byteCapacity];
  }
  
  /**
   * Determine whether an address is aligned to specified length.
   * @param address memory address.
   * @param length byte length.
   * @return true if address is aligned to length.
   */
  @Override protected boolean isAccessAligned (int address, int length) {

      if(length == 0)
          return true;
      else
        return address % length == 0;
  }
  
  /**
   * Convert an sequence of four bytes into a Big Endian integer.
   * @param byteAtAddrPlus0 value of byte with lowest memory address (base address).
   * @param byteAtAddrPlus1 value of byte at base address plus 1.
   * @param byteAtAddrPlus2 value of byte at base address plus 2.
   * @param byteAtAddrPlus3 value of byte at base address plus 3 (highest memory address).
   * @return Big Endian integer formed by these four bytes.
   */
  @Override public int bytesToInteger (byte byteAtAddrPlus0, byte byteAtAddrPlus1, byte byteAtAddrPlus2, byte byteAtAddrPlus3) {

      int big = 0;
      byte byteAtArr[] = new byte[4];
      byteAtArr[0] = byteAtAddrPlus0;
      byteAtArr[1] = byteAtAddrPlus1;
      byteAtArr[2] = byteAtAddrPlus2;
      byteAtArr[3] = byteAtAddrPlus3;

      for(int i = 0; i < 4; i++)
          big += (byteAtArr[i] << 24) >>> 8*i;

      return big;
  }
  
  /**
   * Convert a Big Endian integer into an array of 4 bytes organized by memory address.
   * @param  i an Big Endian integer.
   * @return an array of byte where [0] is value of low-address byte of the number etc.
   */
  @Override public byte[] integerToBytes (int i) {

      byte bytes[] = new byte[4];
      String hex = Integer.toHexString(i);

      while(hex.length() < 8)
          hex = "0" + hex;

      for(int n = 0; n < 4; n++){

          bytes[n] = Integer.valueOf(hex.substring(2*n, 2 + 2*n), 16).byteValue();
      }

      return bytes;
  }
  
  /**
   * Fetch a sequence of bytes from memory.
   * @param address address of the first byte to fetch.
   * @param length  number of bytes to fetch.
   * @throws InvalidAddressException  if any address in the range address to address+length-1 is invalid.
   * @return an array of byte where [0] is memory value at address, [1] is memory value at address+1 etc.
   */
  @Override protected byte[] get (int address, int length) throws InvalidAddressException {

      byte valAt[] = new byte[length];

      for(int i = 0; i < length; i++){

          try {
              valAt[i] = mem[address + i];
          }catch (ArrayIndexOutOfBoundsException e){
              throw new InvalidAddressException();
          }
      }

      return valAt;
  }
  
  /**
   * Store a sequence of bytes into memory.
   * @param  address                  address of the first byte in memory to recieve the specified value.
   * @param  value                    an array of byte values to store in memory at the specified address.
   * @throws InvalidAddressException  if any address in the range address to address+value.length-1 is invalid.
   */
  @Override protected void set (int address, byte[] value) throws InvalidAddressException {

      for(int i = 0; i < value.length; i++){

          try {
              mem[address + i] = value[i];
          }catch(ArrayIndexOutOfBoundsException e){
              throw new InvalidAddressException();
          }
      }
  }
  
  /**
   * Determine the size of memory.
   * @return the number of bytes allocated to this memory.
   */
  @Override public int length () {
    return mem.length;
  }
}
