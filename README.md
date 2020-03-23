# pythonwindocker
This is short but hope useful example on how to run python App GUI from your container with output in Windows host

#### Steps
1. Install on your windows host (VcXsrv). Go to (https://sourceforge.net/projects/vcxsrv/)
   
   ![VcXsrv](https://github.com/Fractal2017/pythonwindocker/blob/master/img/Image-0110.png)
   <img src="/img/Image-0110.png"  width="75%">


   a. Invoke ```XLAUNCH.exe```
   
   ![Xlaunch](https://github.com/Fractal2017/pythonwindocker/blob/master/img/Image-0111.png)

   b. Configuration of Windows X-Server:
      1. Page 1: Allow Multiple windows
      2. Page 2: Start NO client
      3. Page 3: Select all options
      4. Page 4: Save Configuration in %appsuser% directory
      
   ![Config](https://github.com/Fractal2017/pythonwindocker/blob/master/img/Image-0114.png)

2. Create a simple .Dockerfile:
```docker
   # myconfig.Dockerfile
   FROM python:latest
   RUN  pip install pandas==1.0.3
   RUN  pip install scikit-learn
   RUN  pip install scipy
   RUN  pip install matplotlib
```

3. Create the image
   
   `DOS> docker build -t mypyimg:v1 -f myconfig.Dockerfile . ` 

4. From your Windows host obtain the current path and the ip address and assign it to the below environment variables
   
   
   `DOS> set HOME=%cd%`
   
   `DOS> set DISPLAY=<hostipaddress>:0.0`
   
   For example: `DOS> set DISPLAY=172.27.0.66:0.0`

5. Create a container based on that image
   
   `DOS> docker run -dit -e DISPLAY=%DISPLAY% -v %HOME%:/usr/src/myproject --name mypython mypyimg:v1`

6. Create a python file ***"example1.py"*** in your current directory
```py
   # example of a line plot
   from numpy import sin
   from matplotlib import pyplot
   # consistent interval for x-axis
   x = [x*0.1 for x in range(100)]
   # function of x for y-axis
   y = sin(x)
   # create line plot
   pyplot.plot(x, y)
   # show line plot
   pyplot.show()
```

7. Connect to the container, navigate to the file location and run the python code

```
   DOS> docker exec -it mypython /bin/bash
   $ cd /usr/src/myproject
   $ python3 example1.py
```

8. The graphical output should be on your Windows host machine

 ![Output](https://github.com/Fractal2017/pythonwindocker/blob/master/img/Image-0117.png)
