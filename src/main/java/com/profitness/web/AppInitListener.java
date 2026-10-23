package com.profitness.web;

import com.profitness.dsa.DataStore;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.File;

/**
 * Application Lifecycle Listener initializing persistent DSA structures
 * and storage directories when the Servlet Context starts up.
 */
public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String realPath = sce.getServletContext().getRealPath("/");
        if (realPath == null) {
            realPath = System.getProperty("user.dir");
        }

        String dataPath = realPath + File.separator + "data" + File.separator;
        DataStore.setDataDir(dataPath);
        DataStore.getInstance().initializeAll();

        System.out.println("==================================================");
        System.out.println("Pro-Fitness Gym System initialized successfully!");
        System.out.println("Data directory set to: " + dataPath);
        System.out.println("Registered members: " + DataStore.getInstance().getMembers().getSize());
        System.out.println("Active check-ins: " + DataStore.getInstance().getCheckInStack().getSize());
        System.out.println("Queued appointments: " + DataStore.getInstance().getAppointmentQueue().getSize());
        System.out.println("==================================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Persist all records upon server shutdown
        DataStore store = DataStore.getInstance();
        store.saveMembers();
        store.saveCheckIns();
        store.saveAppointments();
        System.out.println("Pro-Fitness Gym System shut down cleanly and persisted data.");
    }
}
