#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static const char *
cpu_perc(void)
{
    static long double a[7], b[7];
    FILE *fp = fopen("/proc/stat","r");
    if (!fp)
        return "CPU: ?";

    fscanf(fp, "cpu %Lf %Lf %Lf %Lf %Lf %Lf %Lf", 
           &a[0], &a[1], &a[2], &a[3], &a[4], &a[5], &a[6]);
    fclose(fp);

    usleep(100000);

    fp = fopen("/proc/stat","r");
    if (!fp)
        return "CPU: ?";
    fscanf(fp, "cpu %Lf %Lf %Lf %Lf %Lf %Lf %Lf", 
           &b[0], &b[1], &b[2], &b[3], &b[4], &b[5], &b[6]);
    fclose(fp);

    long double load = ((b[0]+b[1]+b[2]) - (a[0]+a[1]+a[2])) /
                       ((b[0]+b[1]+b[2]+b[3]) - (a[0]+a[1]+a[2]+a[3])) * 100;
    static char buf[16];
    snprintf(buf, sizeof(buf), " %.0Lf%%", load);
    return buf;
}

static const char *
mem_perc(void)
{
    FILE *fp = fopen("/proc/meminfo", "r");
    if (!fp)
        return "MEM: ?";
    long total, free, buffers, cached;
    fscanf(fp, "MemTotal: %ld kB\n", &total);
    fscanf(fp, "MemFree: %ld kB\n", &free);
    fscanf(fp, "MemAvailable: %ld kB\n", &buffers);
    fscanf(fp, "Buffers: %ld kB\n", &buffers);
    fscanf(fp, "Cached: %ld kB\n", &cached);
    fclose(fp);

    long used = total - free - buffers - cached;
    int perc = (int)((double)used / total * 100);
    static char buf[16];
    snprintf(buf, sizeof(buf), " %d%%", perc);
    return buf;
}

static const char *
battery_perc(void)
{
    FILE *fp = fopen("/sys/class/power_supply/BAT0/capacity", "r");
    if (!fp)
        return "BAT: ?";
    int cap;
    fscanf(fp, "%d", &cap);
    fclose(fp);
    static char buf[16];
    snprintf(buf, sizeof(buf), " %d%%", cap);
    return buf;
}

static const char *
datetime(void)
{
    time_t t = time(NULL);
    struct tm *tm = localtime(&t);
    static char buf[32];
    strftime(buf, sizeof(buf), " %H:%M", tm);
    return buf;
}

static void
setstatus(const char *str)
{
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "xsetroot -name \"%s\"", str);
    system(cmd);
}

int
main(void)
{
    char status[256];
    while (1) {
        snprintf(status, sizeof(status), "%s  %s  %s  %s",
                 cpu_perc(), mem_perc(), battery_perc(), datetime());
        setstatus(status);
        sleep(5);
    }
    return 0;

}
