package com.sg.util;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016101600700749";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCJrT2r08yaQnFtvQxKzab4NW5Ph/G4L69NS4yh6bhsP2jSe43C75h3XhBxPk8d6Rnd5nta6pytT3mIWZh3n8sQ9SnXN9hLml/YvVzpCV/ixcjVBL29oPJ7DCBci1xLcIE+ZkEdMVgzLpd4hjf8cQuPVS/zjvmhjH1HAeeUdEiYYZwGJqPnLD4qAyisaw6fUSk9Tpxo78oBnLQ1OS/y5fPGvGI5iG/8Ovibd8Ioc/Z77soagVLcDO/HpBKCJU67m6M4sF5+bPwegwHMHKQr9R0sixb4MxNCk+/ZLXtNE439a+COYrMv3+bM1Fj5dp6qhp0chhBt7sOa9f0DQdYGem+DAgMBAAECggEATpMD3nwLioKfL+00BcEnKQN9iIBisSbt2qRih8nXCliKH46KUpXho0aZBbh0+PIfZCh1gGbjsnnoN6xCuwsEnxH8pirmFAfv6cfxLcK+6bLNst142K/xk85Q7eBPdXKpII7FXL7bwqI1qoCXlUiDO3N34X5Y9B01JoBsxao0AFrgr0AtoKsp6Ok6g1pKdFadiPYROY6l6i9uRRMktQ3zj9jsCAPDQwiYXKkGd1a5Dxj1YTxCDBOxkIuD0hHi3c9o7s9jeTr/RJ4RpWUbCS6upJckm0YJucnHwKY5sTmiJ5ezGB28ZHm2Y+fJVx/bkrs1Pr3zQ4ggTPmpAYpu/rCp4QKBgQDteWXUL2ho7EaxwBelmLt2raekr7skG+8ehNLTiG9vVjGicURN9aWvrma+7VQkezL0ED4in8YfsQsoSxDhMd0vqSpRGuTGothIiGaNDSZhY/R0cGEoeNM3ssFOyn4UOMBM+98JvAv1ncJEqZ1axWcQIMfy2FJYRm7mPZsKgNR0kwKBgQCUaskWSos/IUF9JAUSJxTTYf8DK3kp7t4g9HGZ174Vr3V/ip0L1nDZfbg2f+ivqneYLekREFupytmh/UY1Gfk2S5BNoDYGcAB0WGkN0R54vbbUV018RDH0rALZsKvxcMXeKd1zIlMMwzA9pUrewjDqQH/2OBm9p1FFlFB2mmVfUQKBgBccW2ac/oJHjFG8KhD5njTcjZYfbA0Fku3ba1Ee1Al3z/jJISadI3THekRWgHvUaY8LDaD8/6ER784KECh6W9ZJlk6yWVVjf7z/WUuc3gFYYu/6B9qSd6vR/7IVTtPU+hID6R7faCKNKdzYzPGKiI8vQYZGuyzQHfbWRAJvqz11AoGBAIe4u1jaJEo/xB6HAOgfuwiu1b/1UmDJYnIqd3Qi+V3lTQKsJH89w4bwU7Pq9kMmFSWh3j9PgTNdH/Xlof1PWjmPkk+aUa1DYPcEHlWXRVFO09GMYHxh9Hj1j8m4qRQqd5d5G1x9KAtEt2m4LSZV2NtuzlW/6bIoPsbtIUPEXy1xAoGAHtsomYq0acKhKPwMvQKmY/Ej5uSgSjI+cjlDgXFmTN6DzhGLgHJgZNIHsCVDKXW1M91ZuAcKCIsxQIp5aCDcyfH53A23qxnSbicHV1LvZK/2iG8/qzj9a2WEpt7+BGfAD9gqBumMG21VXNmb+65ZlzVAguHIGzVgVUvXvaAMH5g=";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAia09q9PMmkJxbb0MSs2m+DVuT4fxuC+vTUuMoem4bD9o0nuNwu+Yd14QcT5PHekZ3eZ7WuqcrU95iFmYd5/LEPUp1zfYS5pf2L1c6Qlf4sXI1QS9vaDyewwgXItcS3CBPmZBHTFYMy6XeIY3/HELj1Uv8475oYx9RwHnlHRImGGcBiaj5yw+KgMorGsOn1EpPU6caO/KAZy0NTkv8uXzxrxiOYhv/Dr4m3fCKHP2e+7KGoFS3Azvx6QSgiVOu5ujOLBefmz8HoMBzBykK/UdLIsW+DMTQpPv2S17TRON/WvgjmKzL9/mzNRY+XaeqoadHIYQbe7DmvX9A0HWBnpvgwIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
//    
	public static String notify_url = "http://lulucc.wicp.vip/alipay.trade.page.pay-JAVA-UTF-8/notify_url1.jsp";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://localhost:8080/alipay.trade.page.pay-JAVA-UTF-8/return_url.jsp";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关alipay 后面要加上dev  从官网下载的demo后面没有dev
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";

//	EnvUtils.setEnv(EnvUtils.EnvEnum.SANDBOX);
//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

