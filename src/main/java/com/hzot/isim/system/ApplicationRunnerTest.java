package com.hzot.isim.system;

import com.hzot.isim.controller.project.template.StreamHandler;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import java.io.*;

@Component
public class ApplicationRunnerTest implements ApplicationRunner {

    @Value("${ansibleTemplate.ansibleBasepath}")
    private String basepath;

    @Override
    public void run(ApplicationArguments args) throws Exception {

        boolean isWindows = System.getProperty("os.name").toLowerCase().contains("win");
        if(!isWindows){
            InputStream inputStream = this.getClass().getResourceAsStream("/ansible/restdevV1.yml");
            File targetFile = new File(basepath+"restdevV1.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);

            inputStream = this.getClass().getResourceAsStream("/ansible/restdevV2.yml");
            targetFile = new File(basepath+"restdevV2.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);

            inputStream = this.getClass().getResourceAsStream("/ansible/dbdevV1.yml");
            targetFile = new File(basepath+"dbdevV1.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);

            inputStream = this.getClass().getResourceAsStream("/ansible/dbdevV2.yml");
            targetFile = new File(basepath+"dbdevV2.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);

            inputStream = this.getClass().getResourceAsStream("/ansible/soapdevV1.yml");
            targetFile = new File(basepath+"soapdevV1.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);

            inputStream = this.getClass().getResourceAsStream("/ansible/soapdevV2.yml");
            targetFile = new File(basepath+"soapdevV2.yml");
            FileUtils.copyInputStreamToFile(inputStream, targetFile);


        }


    }

    public  void writeFileString(String filename,String context) {
        File file = new File(basepath);
        if(!file.isDirectory())
            file.mkdir();//创建目录
        File fileDir = new File(file,filename);
        if(!fileDir.isFile()){
            try {
                fileDir.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            FileWriter fw = new FileWriter(fileDir);//FileWriter写入文件时不能指定编码格式，编码格式是系统默认的编码格式
            fw.write(context); //向文件中写入字符串
            fw.flush(); //刷新
            fw.close(); //关闭流
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String readToString(String fileName) {
        String encoding = "UTF-8";
        File file = new File(fileName);
        Long filelength = file.length();
        byte[] filecontent = new byte[filelength.intValue()];
        try {
            FileInputStream in = new FileInputStream(file);
            in.read(filecontent);
            in.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            return new String(filecontent, encoding);
        } catch (UnsupportedEncodingException e) {
            System.err.println("The OS does not support " + encoding);
            e.printStackTrace();
            return null;
        }
    }

    public static String toConvertString(InputStream is) {
        StringBuffer res = new StringBuffer();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader read = new BufferedReader(isr);
        try {
            String line;
            line = read.readLine();
            while (line != null) {
                res.append(line + " ");
                line = read.readLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != isr) {
                    isr.close();
                    isr.close();
                }
                if (null != read) {
                    read.close();
                    read = null;
                }
                if (null != is) {
                    is.close();
                    is = null;
                }
            } catch (IOException e) {
            }
        }
        return res.toString();
    }


}
