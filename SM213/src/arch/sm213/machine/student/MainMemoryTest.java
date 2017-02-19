package arch.sm213.machine.student;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;
import machine.AbstractMainMemory.InvalidAddressException;

/**
 * Created by Austin on 2017-01-13.
 */
public class MainMemoryTest {

    private int memSize = 32;
    private MainMemory memory = new MainMemory(memSize);

    //region isAccessAlignedTests


    //Tests an aligned address
    @Test
    public void isAccessAlignedYes() throws Exception {
        int address = 65288;
        int length = 4;

        assertEquals(true, memory.isAccessAligned(address, length));
    }


    //Tests an unaligned address
    @Test
    public void isAccessAlignedNo() throws Exception {
        int address = 4;
        int length = 5;

        assertEquals(false, memory.isAccessAligned(address, length));
    }


    //Tests an aligned address with a negative length
    @Test
    public void isAccessAlignedNeg() throws Exception {

        int address = 32;
        int length = -4;

        assertEquals(true, memory.isAccessAligned(address, length));
    }


    //Tests an aligned address when length is zero
    @Test
    public void isAccessAlignedZero() throws Exception {

        int address = 4;
        int length = 0;

        assertEquals(true, memory.isAccessAligned(address, length));
    }

    //endregion


    //region bytesToIntegerTests


    //Tests the base case: 00 00 00 00
    @Test
    public void bytesToIntegerBase() throws Exception {

        byte param = Integer.valueOf(0).byteValue();
        int val = memory.bytesToInteger(param, param, param, param);
        assertEquals(val, 0);
    }


    //Tests a negative number: ff ff ff 00
    @Test
    public void bytesToIntegerNeg() throws Exception {

        byte param0 = Integer.valueOf(0).byteValue();
        byte param1 = Integer.valueOf(-1).byteValue();

        int val = memory.bytesToInteger(param1, param1, param1, param0);
        assertEquals(val, -256);
    }


    //Tests the largest hex number with 4 bytes: ff ff ff ff
    @Test
    public void bytesToIntegerAllF() throws Exception {

        byte param = Integer.valueOf(-1).byteValue();

        int val = memory.bytesToInteger(param, param, param, param);
        assertEquals(val, -1);
    }


    //Tests the largest int value: 2147483647
    @Test
    public void bytesToIntegerLargestInt() throws Exception {

        byte param0 = Integer.valueOf(127).byteValue();
        byte param1 = Integer.valueOf(-1).byteValue();

        int val = memory.bytesToInteger(param0, param1, param1, param1);
        assertEquals(val, 2147483647);
    }


    //Tests the smallest possible int value: -2147483648
    @Test
    public void bytesToIntegerSmallestInt() throws Exception {

        byte param0 = Integer.valueOf(-128).byteValue();
        byte param1 = Integer.valueOf(0).byteValue();

        int val = memory.bytesToInteger(param0, param1, param1, param1);
        assertEquals(val, -2147483648);
    }

    //endregion


    //region integerToBytesTest


    //Tests the base case: 0 to 00 00 00 00
    @Test
    public void integerToBytesBase() throws Exception {

        byte bytes[] = new byte[4];
        byte intToBytes[] = memory.integerToBytes(0);

        for(int i = 0; i < 4; i++)
            bytes[i] = Integer.valueOf(0).byteValue();

        for(int i = 0; i < 4; i++)
            assertEquals(bytes[i], intToBytes[i]);
    }

    //Tests a negative number: -256 to ff ff ff 00
    @Test
    public void integerToBytesNeg() throws Exception {

        byte bytes[] = new byte[4];
        byte intToBytes[] = memory.integerToBytes(-256);

        bytes[0] = -1;
        bytes[1] = -1;
        bytes[2] = -1;
        bytes[3] = 0;

        for(int i = 0; i < 4; i++)
            assertEquals(bytes[i], intToBytes[i]);
    }


    //Tests the largest hex number with 4 bytes: -1 to ff ff ff ff
    @Test
    public void integerToBytesAllF() throws Exception {

        byte bytes[] = new byte[4];
        byte intToBytes[] = memory.integerToBytes(-1);

        for(int i = 0; i < 4; i++)
            bytes[i] = Integer.valueOf(-1).byteValue();

        for(int i = 0; i < 4; i++)
            assertEquals(bytes[i], intToBytes[i]);
    }


    //Tests the largest int value: 2147483647 to 7f ff ff ff
    @Test
    public void integerToBytesLargestInt() throws Exception {

        byte bytes[] = new byte[4];
        byte intToBytes[] = memory.integerToBytes(2147483647);

        bytes[0] = 127;
        bytes[1] = -1;
        bytes[2] = -1;
        bytes[3] = -1;

        for(int i = 0; i < 4; i++)
            assertEquals(bytes[i], intToBytes[i]);
    }


    //Tests the smallest possible int value: -2147483648 to 8f ff ff ff
    @Test
    public void integerToBytesSmallestInt() throws Exception {

        byte bytes[] = new byte[4];
        byte intToBytes[] = memory.integerToBytes(-2147483648);

        bytes[0] = -128;
        bytes[1] = 0;
        bytes[2] = 0;
        bytes[3] = 0;

        for(int i = 0; i < 4; i++)
            assertEquals(bytes[i], intToBytes[i]);
    }

    //endregion


    //region GetSetTests


    //Tests a working GetSet
    @Test
    public void GetSet() throws Exception {

        int length = 4;
        int address = 10;
        byte bytes[] = new byte[length];

        bytes[0] = -1;
        bytes[1] = 127;
        bytes[2] = 0;
        bytes[3] = -128;

        memory.set(address, bytes);

        byte get[] = memory.get(address, length);

        for(int i = 0; i < length; i++)
            assertEquals(bytes[i], get[i]);

    }


    //Tests a larger working GetSet
    @Test
    public void GetSetLarge() throws Exception {

        int length = 16;
        int address = 10;
        byte bytes[] = new byte[length];

        for(int i = 0; i < length; i++)
            bytes[i] = Integer.valueOf(i + 15).byteValue();

        memory.set(address, bytes);

        byte get[] = memory.get(address, length);

        for(int i = 0; i < length; i++)
            assertEquals(bytes[i], get[i]);

    }


    //Tests Set with an invalid address
    @Test(expected = InvalidAddressException.class)
    public void SetInvalid() throws Exception {

        int length = 16;
        int address = 32;
        byte bytes[] = new byte[length];

        for(int i = 0; i < length; i++)
            bytes[i] = Integer.valueOf(i).byteValue();

        memory.set(address, bytes);
    }


    //Tests Get with an invalid address
    @Test(expected = InvalidAddressException.class)
    public void GetInvalid() throws Exception {

       memory.get(memSize, 10);
    }

    //endregion
}