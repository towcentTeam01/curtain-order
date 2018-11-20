接口测试用例：
public class MessageControllerTest extends BaseAppTest {
	
	@Test
	public void main() throws IOException {
		// setAccount("13688845815"); // 指定账号   
		// setPasswd("");             // 指定密码
		
		String path = "message/main"; // 接口地址
		BaseParam vo = new BaseParam();
		super.setCommonAttribute(vo); // 公共参数
		super.setLoginFlag(vo);       // 是否需要登录
		
		String context = sendHttp(vo, path); // 发送http请求
		System.out.println(context);
		assertEquals("000", parseResultCode(context));
	}
}

环境切换:
见环境切换配置文件env