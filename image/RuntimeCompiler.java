import java.io.IOException;
import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

public class RuntimeCompiler {
  public static void main(String[] args) throws IOException {
    System.out.println("Compiler pre-warming...");
    JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
    int res = 99;

    while(true) {
      res = compiler.run(null, null, null, "./HelloWorld.java");
      System.out.println("Compiler ready. Press a key.");
      System.in.read();
      res = compiler.run(null, null, null, "./HelloAgainWorld.java");
      System.out.println("Compile finished. Result: "+ res);
      System.in.read();
    }
  }
}