$mockFileStream = @"
public class MockFileStream : System.IO.FileStream {
    public string Str { get; set; }
    private long index = 0;
    
    private static int tempFileCounter = 0;

    public MockFileStream(string str) :
        base(
            nextTempFile(),
            System.IO.FileMode.OpenOrCreate
        ) {
        this.Str = str;
        tempFileCounter++;
    }
    
    public override int ReadByte() {
        if (index == Str.Length) {
            return -1;
        }
        char c = Str[(int)index];
        index++;
        return (byte)c;
    }
    
    public override long Seek(long offset, System.IO.SeekOrigin origin) {
        switch(origin) {
            case System.IO.SeekOrigin.Begin:
                index = offset;
                break;
            case System.IO.SeekOrigin.Current:
                index += offset;
                break;
            case System.IO.SeekOrigin.End:
                index = Str.Length + offset - 1;
                break;
        }
        return index;
    }
    
    private static string nextTempFile() {
        return string.Format("temp{0}.txt", tempFileCounter);
    }
}
"@