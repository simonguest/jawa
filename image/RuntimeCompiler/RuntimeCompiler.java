import java.io.IOException;
import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

public class RuntimeCompiler {
  public static void main(String[] args) throws IOException {
    String file = args[0];
    System.out.print("Compiling " + file + "\n");
    JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
    int res = compiler.run(null, null, null, file);
    System.out.println("Compile finished. Result: "+ res);
  }
}