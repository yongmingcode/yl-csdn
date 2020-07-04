package com.yl.controller;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;
import java.util.*;

/**
 * @author kuiburen
 * @date 2020/7/3 22:10
 * @desc
 */
@RestController
public class JavaInfoController {

    @RequestMapping("info")
    public ModelAndView javaInfo(ModelAndView modelAndView, HttpServletRequest request){
        Map<String, String> map = new HashMap<String, String>();
        Enumeration headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String key = (String) headerNames.nextElement();
            String value = request.getHeader(key);
            map.put(key, value);
        }
        Cookie[] cookies = request.getCookies();

        modelAndView.addObject("cookies", cookies);
        modelAndView.addObject("header", map);
        modelAndView.setViewName("freemarker");
        return modelAndView;
    }

    @RequestMapping("jvminfo")
    public List<List<Map<String, Object>>> jvmInfo(){
        List<List<Map<String, Object>>> result = new ArrayList<List<Map<String, Object>>>(2);

        // 内存使用率
        MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
        List<Map<String, Object>> memoryResult = new ArrayList<Map<String, Object>>();
        Map<String, Object> info = new HashMap<String, Object>();
        info.put("initial", String.format("%.2f GB", (double)memoryMXBean.getHeapMemoryUsage().getInit() /1073741824));
        info.put("used", String.format("%.2f GB", (double)memoryMXBean.getHeapMemoryUsage().getUsed() /1073741824));
        info.put("max", String.format("%.2f GB", (double)memoryMXBean.getHeapMemoryUsage().getMax() /1073741824));
        info.put("committed", String.format("%.2f GB", (double)memoryMXBean.getHeapMemoryUsage().getCommitted() /1073741824));
        memoryResult.add(info);
        result.add(memoryResult);

        // CPU使用情况
        ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
        List<Map<String, Object>> threadResult = new ArrayList<Map<String, Object>>();
        for(Long threadID : threadMXBean.getAllThreadIds()) {
            ThreadInfo threadInfo = threadMXBean.getThreadInfo(threadID);
            Map<String, Object> threadMap = new HashMap<String, Object>();
            threadMap.put("threadName", threadInfo.getThreadName());
            threadMap.put("threadState", threadInfo.getThreadState());
            threadMap.put("cpuTime", String.format("CPU time: %s ns", threadMXBean.getThreadCpuTime(threadID)));
            threadResult.add(threadMap);
        }
        result.add(threadResult);

        // 磁盘使用率
        String osName = System.getProperty("os.name");
        List<Map<String, Object>> driveResult = new ArrayList<Map<String, Object>>();
        Map<String, Object> drive = new HashMap<String, Object>();
        if (osName.contains("Windows")) {
            File cDrive = new File("C:");
            drive.put("total", String.format("%.2f GB", (double) cDrive.getTotalSpace() / 1073741824));
            drive.put("free", String.format("%.2f GB", (double) cDrive.getFreeSpace() / 1073741824));
            drive.put("usable", String.format("%.2f GB", (double) cDrive.getUsableSpace() / 1073741824));
        } else if (osName.contains("Linux")) {
            File root = new File("/");
            drive.put("total", String.format("%.2f GB", (double) root.getTotalSpace() / 1073741824));
            drive.put("free", String.format("%.2f GB", (double) root.getFreeSpace() / 1073741824));
            drive.put("usable", String.format("%.2f GB", (double) root.getUsableSpace() / 1073741824));
//            System.out.println(String.format("Total space: %.2f GB", (double) root.getTotalSpace() / 1073741824));
//            System.out.println(String.format("Free space: %.2f GB", (double) root.getFreeSpace() / 1073741824));
//            System.out.println(String.format("Usable space: %.2f GB", (double) root.getUsableSpace() / 1073741824));
        }
        driveResult.add(drive);
        result.add(driveResult);

        return result;
    }
}
